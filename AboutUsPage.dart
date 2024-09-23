import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/images/band1.jpeg', width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'GravityBand',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Founded in Sri Lanka, GravityBand has been captivating audiences with their unique blend of music since 2010. Known for their vibrant performances and dynamic sound, the band combines traditional Sri Lankan music with modern genres to create a mesmerizing musical experience.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Meet the Band',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
            ),
            Card(
              margin: EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.deepPurple),
                    title: Text('John Doe - Lead Vocalist'),
                    subtitle: Text('John brings a powerful voice and an energetic stage presence to every performance.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.deepPurple),
                    title: Text('Jane Smith - Drummer'),
                    subtitle: Text('Jane\'s rhythms form the backbone of the band\'s signature sound.'),
                  ),
                ],
              ),
            ),
            Image.asset('assets/images/band2.jpeg', width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Join Us at Our Next Concert',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'With a passion for music and a commitment to delivering powerful performances, GravityBand has become one of the most sought after musical acts in the region. Join us at our next concert to experience the magic live!',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Discover Our Tour Dates'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
