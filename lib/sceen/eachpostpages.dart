import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:study_shelf/sceen/homepage.dart';
import 'package:study_shelf/sceen/process_uname.dart';
import 'package:study_shelf/sceen/subjectgroup.dart';
import 'package:url_launcher/url_launcher.dart';

class eachPost extends StatelessWidget {
  final String Title;
  final String Url;
  final String Format;
  final String Caption;
  final String Tag;
  final String Uname;
  final String Subject;
  const eachPost({Key? key, required this.Title, required this.Url, required this.Format, required this.Caption, required this.Tag, required this.Uname, required this.Subject}) : super(key: key);

  Future<void> _launchInBrowser(String url, {bool forceWebView = false, bool enableJavaScript = false}) async {
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    late QuerySnapshot snapshotData;
    final bool isExecuted = true;
    return Scaffold(
      backgroundColor: const Color(0xFFF1EEEE),
      appBar: AppBar(
        title: Text(Title, style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: const Color(0xFFCAB8E0),
        leading: IconButton(
            icon: Icon(CupertinoIcons.back, size: 35, color: Colors.black),
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));}),
        actions: [
          IconButton(icon: Icon(Icons.download_rounded, color: const Color(0xFF585858),),
              onPressed: () async {
                await _launchInBrowser(Url);
              }
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30, bottom: 20),
                height: 202, width: 267,
                decoration: BoxDecoration(
                  color: Color((Format == 'pdf') ? (0xFFCAB8E0) : (0xFFFFFFFF)),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage((Format == 'pdf') ?  'https://i.postimg.cc/VNTd9w2Q/PDF-File-Online-1-removebg-preview.png' : Url),
                  ),
                ),
              ),
            ),
            Container(child: Text(Title+' :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
            Container(child: Text(Caption, style: TextStyle(fontSize: 20))),
            Container(child: Text('tag : #'+Tag)),
            ElevatedButton(
              child: Text(Subject, style: TextStyle(
              fontSize: 16, color: const Color(0xFF585858)),),
              style: ElevatedButton.styleFrom(
              primary: Color(0xFFCAB8E0).withOpacity(0.33),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
              minimumSize: (Size(50, 30))),
              onPressed: () {}),
            Text('Created by : '+Uname),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: double.infinity, height: 328,
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  Container(margin: EdgeInsets.only(top: 20, bottom: 7), child: Text('Comments', style: TextStyle(color: const Color(0xFF585858), fontSize: 20, fontWeight: FontWeight.bold),)),
                  Container(height: 7, width: 125, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFFCAB8E0)),)
                ],
              ),
            ),
           ]
          )
        ),
      );
  }
}

class eachReq extends StatelessWidget {
  final String Title;
  final String Caption;
  final String Tag;
  final String Uname;
  final String Subject;
  const eachReq({Key? key, required this.Title, required this.Caption, required this.Tag, required this.Uname, required this.Subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: const Color(0xFFF1EEEE),
          appBar: AppBar(
          title: Text(Title, style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: const Color(0xFFCAB8E0),
        leading: IconButton(
        icon: Icon(CupertinoIcons.back, size: 35, color: Colors.black),
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));}),
      ),
      body: Container(
          child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 30, bottom: 20),
                    height: 150, width: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCAB8E0),
                      borderRadius: BorderRadius.circular(20),
                      ),
                    child: Icon(Icons.paste_rounded, color: const Color(0xFF585858), size: 80,),
                    ),
                  ),
                Container(child: Text(Title+' :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                Container(child: Text(Caption, style: TextStyle(fontSize: 20))),
                Container(child: Text('tag : #'+Tag)),
                ElevatedButton(
                    child: Text(Subject, style: TextStyle(
                        fontSize: 16, color: const Color(0xFF585858)),),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFCAB8E0).withOpacity(0.33),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        minimumSize: (Size(50, 30))),
                    onPressed: () {}),
                Text('Request by : '+Uname),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  width: double.infinity, height: 358,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                  ),
                  child: Column(
                    children: [
                      Container(margin: EdgeInsets.only(top: 20, bottom: 7), child: Text('Comments', style: TextStyle(color: const Color(0xFF585858), fontSize: 20, fontWeight: FontWeight.bold),)),
                      Container(height: 7, width: 125, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFFCAB8E0)),)
                    ],
                  ),
                ),
              ]
          )
      ),
    );
  }
}

