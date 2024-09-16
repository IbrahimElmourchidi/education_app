import 'package:flutter/material.dart';

void main() {
  runApp(const EducationApp());
}

class EducationApp extends StatelessWidget {
  const EducationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Hello world!"),
        ),
      ),
    );
  }
}
