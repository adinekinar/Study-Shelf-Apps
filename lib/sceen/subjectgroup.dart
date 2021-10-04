import 'package:flutter/material.dart';

class subjectGroup extends StatefulWidget {
  final String Subject;
  const subjectGroup({Key? key, required this.Subject}) : super(key: key);

  @override
  _subjectGroupState createState() => _subjectGroupState();
}

class _subjectGroupState extends State<subjectGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCAB8E0),
      ),
    );
  }
}
