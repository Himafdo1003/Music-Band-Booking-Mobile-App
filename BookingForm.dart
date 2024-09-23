import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'booking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingForm extends StatefulWidget {
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final functionNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  String _selectedDate = '';
  String _selectedSession = 'morning';
  List<DateTime> _unavailableDates = [];
  final List<String> _eventTypes = [
    'Wedding',
    'Birthday Party',
    'Engagement',
    'Dinner Dance',
    'Private Party',
    'Indoor Concert',
    'Outdoor Concert',
  ];

  @override
  void initState() {
    super.initState();
    _fetchUnavailableDates();
  }

  _fetchUnavailableDates() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:5000/events'));
      if (response.statusCode == 200) {
        List<dynamic> dates = json.decode(response.body);
        setState(() {
          _unavailableDates =
              dates.map((date) => DateTime.parse(date['event_date'])).toList();
        });
      } else {
        throw Exception('Failed to load dates');
      }
    } catch (e) {
      print('Failed to load dates: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime date) {
        // Disable selection of unavailable dates
        return !_unavailableDates.any((unavailableDate) =>
            date.year == unavailableDate.year &&
            date.month == unavailableDate.month &&
            date.day == unavailableDate.day);
      },
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _selectedDate =
            "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  String _selectedEventType = 'Wedding'; // Default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Band'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Your Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedEventType,
                decoration: InputDecoration(
                  labelText: '',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedEventType = newValue!;
                  });
                },
                items:
                    _eventTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the function type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: contactNumberController,
                decoration: InputDecoration(labelText: 'Contact Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(_selectedDate.isEmpty
                    ? 'Select Date'
                    : 'Date: $_selectedDate'),
              ),
              DropdownButton<String>(
                value: _selectedSession,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSession = newValue!;
                  });
                },
                items: <String>['morning', 'night']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitBooking();
                  }
                },
                child: Text('Submit Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
void _submitBooking() async {

  var url = Uri.parse('https://gravityband.online/index.php');


  Map<String, String> data = {
    'name': nameController.text,
    'contactNumber': contactNumberController.text,
    'selectedDate': _selectedDate,
    'selectedSession': _selectedSession,
    'eventType': _selectedEventType, 
  };

  try {
   
    print(nameController.text);
    print(_selectedEventType);
    print(contactNumberController.text);
    print(_selectedDate);
    print(_selectedSession);


    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: data, 
    );

    if (response.statusCode == 200) {
      print("Booking submitted successfully.");
      print("Response body: ${response.body}");

    } else {
 
      print("Failed to submit booking. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    
    }
  } catch (e) {
 
    print("Error submitting booking: $e");

  }
}


  @override
  void dispose() {
    nameController.dispose();
    functionNameController.dispose();
    contactNumberController.dispose();
    super.dispose();
  }
}
