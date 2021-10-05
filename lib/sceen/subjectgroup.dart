import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_shelf/sceen/process_uname.dart';

class subjectGroup extends StatelessWidget {
  final QuerySnapshot snapshotData;
  final String Subject;
  const subjectGroup({Key? key, required this.Subject, required this.snapshotData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EEEE),
      appBar: AppBar(
        title: Text(Subject),
        backgroundColor: const Color(0xFFCAB8E0),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height),
          ),
          itemCount: snapshotData.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Container(
                width: 179, height: 370,
                decoration: BoxDecoration(color: const Color(0xFFCAB8E0).withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      width: 179, height: 190, decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        child: Text(snapshotData.docs[index]['Caption file'], style: TextStyle(fontSize: 13, color: const Color(0xFF585858)),),
                        style: ElevatedButton.styleFrom(primary: Color(0xFFCAB8E0).withOpacity(0.33), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: (Size(30, 25))),
                        onPressed: () {},
                      ),),
                    Container(child: Text(snapshotData.docs[index]['Sub-subject Tag']),),
                    Container(child: Text(snapshotData.docs[index]['Title'], style: TextStyle(fontSize: 18),),),
                    Container(child: Text(snapshotData.docs[index]['Username']),),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

