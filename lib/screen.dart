import 'package:flutter/material.dart';
import 'package:music_band/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onDone() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7B1FA2), // Lighter purple
              Color(0xFF4A148C)  // Darker purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: <Widget>[
              splashScreenPage("Experience the Sound", "Discover unique melodies with our exclusive performances."),
              splashScreenPage("Innovative Style", "We blend traditional and modern music for a perfect symphony."),
              splashScreenPage("Join Our Concerts", "Book your tickets and enjoy unforgettable musical nights."),
            ],
          ),
        ),
      ),
      bottomSheet: _currentPage == 2 ? bottomSheetButton() : pageIndicator(),
    );
  }

  Widget splashScreenPage(String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.music_note, color: Colors.white, size: 80),
        SizedBox(height: 24),
        Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 12),
        Text(subtitle, style: TextStyle(fontSize: 18, color: Colors.white70), textAlign: TextAlign.center),
      ],
    );
  }

  Widget pageIndicator() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) => buildDot(index: index)),
      ),
    );
  }

  Widget bottomSheetButton() {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.deepPurple,
      child: TextButton(
        child: Text("GET STARTED", style: TextStyle(fontSize: 20, color: Colors.white)),
        onPressed: _onDone,
      ),
    );
  }

  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.white : Colors.white60,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
