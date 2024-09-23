import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class BookingForm extends StatefulWidget {
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final contactNumberController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedSession;
  Map<DateTime, List<String>> sessionAvailability = {};
  String? _selectedEventType;

  final List<String> eventTypes = [
    'Wedding', 'Home coming', 'Engagement', 'Corporate Events', 'Dinner Dance', 
    'Birthday Party', 'Wedding Anniversary Party', 'Concerts- 70s', 'Concerts- Thaala', 
    'Concerts- MS', 'Other', 'Concerts- General', 'Concerts- Thaama 35'
  ];

  @override
  void initState() {
    super.initState();
    _fetchEventTimes();
  }

  _fetchEventTimes() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:5000/events'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        Map<DateTime, List<String>> tempSessionAvailability = {};
        for (var item in data) {
          DateTime date = DateTime.parse(item['Event_Date']);
          String session = item['Event_Time'];
          if (tempSessionAvailability.containsKey(date)) {
            tempSessionAvailability[date]?.add(session);
          } else {
            tempSessionAvailability[date] = [session];
          }
        }
        setState(() {
          sessionAvailability = tempSessionAvailability;
        });
      } else {
        throw Exception('Failed to load event times');
      }
    } catch (e) {
      print('Failed to load event times: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime date) {
        // Check if both Morning and Evening are booked
        return sessionAvailability[date]?.length != 2;
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedSession = null; // Reset session when date changes
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Band', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedEventType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedEventType = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Event Type',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.event),
                ),
                items: eventTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Please select the function type' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: contactNumberController,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(_selectedDate == null ? 'Select Date' : 'Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'),
              ),
              if (_selectedDate != null)
                DropdownButton<String>(
                  value: _selectedSession,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSession = newValue!;
                    });
                  },
                  items: _availableSessions(_selectedDate).map<DropdownMenuItem<String>>((String session) {
                    return DropdownMenuItem<String>(
                      value: session,
                      child: Text(session),
                    );
                  }).toList(),
                  hint: Text('Select Session'),
                ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _selectedSession != null && _selectedEventType != null) {
                    _submitBooking();
                  }
                }, 
                child: Text('Submit Booking'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _availableSessions(DateTime? date) {
    if (date != null) {
      List<String> bookedSessions = sessionAvailability[date] ?? [];
      List<String> allSessions = ['Morning', 'Evening'];
      return allSessions.where((session) => !bookedSessions.contains(session)).toList();
    }
    return [];
  }

  void _submitBooking() async {
    var url = Uri.parse('http://gravityband.online/index.php');
    Map<String, String> data = {
      'name': nameController.text,
      'contactNumber': contactNumberController.text,
      'selectedDate': _selectedDate!.toIso8601String(),
      'selectedSession': _selectedSession!,
      'eventType': _selectedEventType!,
    };

    try {
      var response = await http.post(url, headers: {'Content-Type': 'application/x-www-form-urlencoded'}, body: data);
      if (response.statusCode == 200) {
       
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking submitted successfully.')));
      } else {
        throw Exception('Failed to submit booking. Status code: ${response.statusCode}');
      }
    } catch (e) {
       print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error submitting booking: $e')));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    contactNumberController.dispose();
    super.dispose();
  }
}
