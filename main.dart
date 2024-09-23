import 'package:flutter/material.dart';
import 'package:music_band/BookingForm.dart';
import 'package:music_band/firebase_options.dart';
import 'package:music_band/navigation.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}