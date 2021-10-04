import 'package:flutter/material.dart';

class subjectGroup extends StatelessWidget {
  final String Subject;
  const subjectGroup({Key? key, required this.Subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(Subject),
        backgroundColor: const Color(0xFFCAB8E0),
      ),
    );
  }
}

