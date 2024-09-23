class Booking {
  String id;
  String name;
  String functionName;
  String contactNumber;
  String date; 
  String session; 

  Booking({
    required this.id,
    required this.name,
    required this.functionName,
    required this.contactNumber,
    required this.date,
    required this.session,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'functionName': functionName,
      'contactNumber': contactNumber,
      'date': date,
      'session': session,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      name: map['name'],
      functionName: map['functionName'],
      contactNumber: map['contactNumber'],
      date: map['date'],
      session: map['session'],
    );
  }
}
