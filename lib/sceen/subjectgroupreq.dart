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
              width: MediaQuery.of(context).size.width/0.5, height: MediaQuery.of(context).size.height/6.5,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFFCAB8E0).withOpacity(0.2), borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(width: 75, height: 75, margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10), decoration: BoxDecoration(color: const Color(0xFFCAB8E0), borderRadius: BorderRadius.circular(25)),child: Icon(Icons.paste_rounded, size: 35, color: const Color(0xFF585858),)),
                      Text(snapshotData.docs[index]['Username']),
                    ],
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:  15,),
                        Container(child: Text(snapshotData.docs[index]['Title'])),
                        //Container(child: Text(snapshotData.docs[index]['Caption request']),),
                        SizedBox(height:  10,),
                        Container(child: Text('#'+snapshotData.docs[index]['Sub-subject Tag']),),
                        SizedBox(height:  10,),
                        Container(
                          child: ElevatedButton(
                            child: Text(snapshotData.docs[index]['Subject'], style: TextStyle(fontSize: 13, color: const Color(0xFF585858)),),
                            style: ElevatedButton.styleFrom(primary: Color(0xFFCAB8E0).withOpacity(0.33), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: (Size(30, 25))),
                            onPressed: () {},
                          ),),
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