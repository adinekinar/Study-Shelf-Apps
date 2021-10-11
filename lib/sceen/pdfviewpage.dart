import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import 'package:study_shelf/sceen/eachpostpages.dart';

class pdfViewerpage extends StatefulWidget {
  final File file;
  const pdfViewerpage({Key? key, required this.file}) : super(key: key);

  @override
  _pdfViewerpageState createState() => _pdfViewerpageState();
}

class _pdfViewerpageState extends State<pdfViewerpage> {
  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCAB8E0),
        title: Text(name),
      ),
      body: PDFView(
        filePath: widget.file.path,
      ),
    );
  }
}
