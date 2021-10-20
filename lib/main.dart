import 'package:flutter/material.dart';

import 'future/presentation/screens/phone_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhoneBook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PhoneScreen(),
    );
  }
}
