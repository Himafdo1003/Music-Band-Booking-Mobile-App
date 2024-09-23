import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

void _submitForm() async {
  var url = Uri.parse('http://gravityband.online/contact.php');

  try {
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'name': _nameController.text,
        'email': _emailController.text,
        'message': _messageController.text,
      },
    );

    if (response.statusCode == 301 || response.statusCode == 302) {
  
      var newUrl = response.headers['location'];
      if (newUrl != null) {
     
        url = Uri.parse(newUrl);
        response = await http.post(
          url,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {
            'name': _nameController.text,
            'email': _emailController.text,
            'message': _messageController.text,
          },
        );
      }
    }

   
    if (response.statusCode == 200) {
      print("Response body: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thank you! Your message has been sent.')),
      );
    } else {
      print("Response status: ${response.statusCode}");
      throw Exception('Failed to load post');
    }
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error sending message. Please try again later.')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Message',
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitForm,
           child: Text(
  'Submit',
  style: TextStyle(color: Colors.white),
),

              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Set the background color
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
