import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  final List<Map<String, String>> members = [
    // Your members data here...
    {
      'name': 'Devin',
      'description': 'Introducing Devin Don, the heartbeat behind Gravity Band is unforgettable sound.As our master of rhythm,Devin is drumming prowess electrifies stages and ignites crowds with every beat.',
      'image': 'assets/images/member1.jpg'
    },
    {
      'name': 'Rukshan',
      'description': 'Meet Rukshan Mudliyer, the charismatic voice and soulful strings of Gravity Band. As our lead vocalist and guitarist, Rukshan captivates audiences with his dynamic stage presence and heartfelt performances. His emotive vocals and skillful guitar melodies intertwine to create an unforgettable sonic experience.',
      'image': 'assets/images/member2.jpg'
    },
    {
      'name': 'Rashean',
      'description': 'Introducing Rashean Fernando, the vocal powerhouse of Gravity Band. With a voice that resonates with passion and emotion, Rashean brings soulful depth to our performances.',
      'image': 'assets/images/member3.jpg'
    },
    {
      'name': 'Kaweesha',
      'description': 'Meet Kaweesha Fernando, the soulful anchor of Gravity Band is melodies. With finesse and flair, Kaweesha is bass guitar expertise lays down the foundation of our sound, weaving together rhythm and harmony with unmatched skill.',
      'image': 'assets/images/member4.jpg'
    },
    {
      'name': 'Sandul',
      'description': '"Meet Sandul Fernando, the maestro of melody in Gravity Band. With fingers that dance across the strings, Sandul is lead guitar mastery weaves intricate harmonies and electrifying solos that mesmerize audiences. ',
      'image': 'assets/images/member5.jpg'
    },
    {
      'name': 'Dinith',
      'description': 'Introducing Dinith Perera, the keyboard virtuoso of Gravity Band. With finesse and flair, Dinith is mastery of the keys infuses our music with rich layers of melody and harmony.',
      'image': 'assets/images/member6.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GRAVITY Online'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    members[index]['image']!,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          members[index]['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          members[index]['description']!,
                          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
