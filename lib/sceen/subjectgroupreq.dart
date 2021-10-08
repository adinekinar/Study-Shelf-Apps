import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_shelf/sceen/homepagereq.dart';
import 'package:study_shelf/sceen/process_uname.dart';

class subjectGroupreq extends StatelessWidget {
  final QuerySnapshot snapshotData;
  final String Subject;
  const subjectGroupreq({Key? key, required this.Subject, required this.snapshotData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF1EEEE),
    appBar: AppBar(
      title: Text(Subject, style: TextStyle(color: Colors.black),),
      backgroundColor: const Color(0xFFCAB8E0),
      leading: IconButton(
      icon: Icon(CupertinoIcons.back, size: 35, color: Colors.black),
      onPressed: () {
        //snapshotData.docs[index]['Subject'].clear();
        Navigator.push(context, MaterialPageRoute(builder: (context) => Homreq()));
      }),
    ),
    body: ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, index) {
          return Center(
            child: Container(
              width: 372, height: 132,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFFCAB8E0).withOpacity(0.2), borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  Container(width: 75, height: 75, margin: EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFCAB8E0), borderRadius: BorderRadius.circular(25)),child: Icon(Icons.paste_rounded, size: 35, color: const Color(0xFF585858),)),
                  Container(
                    child: Column(
                      children: [
                        Container(margin: EdgeInsets.only(top: 15), child: Text(snapshotData.docs[index]['Title'])),
                        //Container(child: Text(snapshotData.docs[index]['Caption request']),),
                        Container(
                          child: ElevatedButton(
                            child: Text(snapshotData.docs[index]['Subject'], style: TextStyle(fontSize: 13, color: const Color(0xFF585858)),),
                            style: ElevatedButton.styleFrom(primary: Color(0xFFCAB8E0).withOpacity(0.33), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: (Size(30, 25))),
                            onPressed: () {},
                          ),),
                        Container(child: Text('#'+snapshotData.docs[index]['Sub-subject Tag']),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
  );
  }
}