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
  int pages = 0;
  int indexpages = 0;
  late PDFViewController controller;
  @override
  Widget build(BuildContext context) {
    final text = '${indexpages+1} of ${pages}';
    final name = basename(widget.file.path);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCAB8E0),
        title: Text(name),
        actions: [
          Center(child: Text(text, style: TextStyle(fontSize: 18),)),
          IconButton(icon: Icon(Icons.chevron_left_rounded, size: 32,), onPressed: () {
            final page = indexpages == 0 ? pages : indexpages - 1;
            controller.setPage(page);
          },),
          IconButton(icon: Icon(Icons.chevron_right_rounded, size: 32,), onPressed: () {
            final page = indexpages == indexpages - 1 ? 0 : indexpages + 1;
            controller.setPage(page);
          },),
        ],
      ),
      body: PDFView(
        filePath: widget.file.path,
        pageSnap: true,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) => setState(() => this.controller = controller),
        onPageChanged: (indexpages, _) => setState(() => this.indexpages = indexpages!),
      ),
    );
  }
}
