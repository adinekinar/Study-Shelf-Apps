import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:study_shelf/sceen/process_uname.dart';
import 'package:study_shelf/sceen/subjectgroupreq.dart';

class grupingTemp extends StatelessWidget {

  final String Subject;
  grupingTemp({Key? key, required this.Subject}) : super(key: key);

  final bool isExecuted = true;

  @override
  Widget build(BuildContext context) {
    late QuerySnapshot snapshotData;
    return GetBuilder <GroupReq> (
      init: GroupReq(),
      builder: (val) {
        return ElevatedButton(
          child: Text(Subject, style: TextStyle(fontSize: 13, color: const Color(0xFF585858)),),
          style: ElevatedButton.styleFrom(primary: Color(0xFFCAB8E0).withOpacity(0.33), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: (Size(30, 25))),
          onPressed: () { (snapshotData != null) ?
          val.GrReq(Subject).then((value) {
            snapshotData = value;
          }): (snapshotData = Subject as QuerySnapshot<Object?>);
          isExecuted ? Navigator.push(context, MaterialPageRoute(builder: (context) => subjectGroupreq(Subject : Subject, snapshotData: snapshotData,))) : {};
          },
        );
      },);
  }
}
