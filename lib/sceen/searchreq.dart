import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:study_shelf/sceen/homepagereq.dart';
import 'package:study_shelf/sceen/process_uname.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_shelf/sceen/subjectgroupreq.dart';

class searchReqpages extends StatefulWidget {
  const searchReqpages({Key? key}) : super(key: key);

  @override
  _searchReqpagesState createState() => _searchReqpagesState();
}

class _searchReqpagesState extends State<searchReqpages> {
  final searchcont = TextEditingController();
  late QuerySnapshot snapshotData;
  bool isExecuted = false;
  @override
  Widget build(BuildContext context) {

    Widget searchdisp() {
      return ListView.builder(
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
                        SizedBox(height:  10,),
                        Container(child: Text('#'+snapshotData.docs[index]['Sub-subject Tag']),),
                        SizedBox(height:  10,),
                        GetBuilder<GroupPost> (
                          init: GroupPost(),
                          builder: (val) {
                            return Container(
                                child: ElevatedButton(
                                    child: Text(snapshotData.docs[index]['Subject'], style: TextStyle(fontSize: 13, color: const Color(0xFF585858)),),
                                    style: ElevatedButton.styleFrom(primary: Color(0xFFCAB8E0).withOpacity(0.33), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: (Size(30, 25))),
                                    onPressed: () { (snapshotData != null) ?
                                    val.GrPost(snapshotData.docs[index]['Subject']).then((value) {
                                      snapshotData = value;
                                      snapshotData.docs[index]['Subject'].clear();
                                    }): (snapshotData = snapshotData.docs[index]['Subject']);
                                    isExecuted ? Navigator.push(context, MaterialPageRoute(builder: (context) => subjectGroupreq(Subject : snapshotData.docs[index]['Subject'], snapshotData: snapshotData,))) : {};
                                    }
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
        icon: Icon(CupertinoIcons.back, size: 35, color: Colors.black),
          onPressed: () {
          //snapshotData.docs[index]['Subject'].clear();
          Navigator.push(context, MaterialPageRoute(builder: (context) => Homreq()));
          }),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_rounded, color: Colors.black),
            onPressed: () {
              searchcont.clear();
              setState(() {
                isExecuted = false;
              });
            },),
          GetBuilder<DatacontReq>(
              init: DatacontReq(),
              builder: (val) {
                return IconButton(
                    icon: Icon(Icons.search_rounded, size: 26, color: Colors.black),
                    onPressed: () {
                      val.Searchreq(searchcont.text).then((value) {
                        snapshotData = value;
                        setState(() {
                          isExecuted = true;
                        });
                      });
                    });
              }
          ),
        ],
        title: TextField(
          controller: searchcont,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Search keyword..',
          ),
        ),
        backgroundColor: const Color(0xFFC4B1DC),
      ),
      body: isExecuted ? searchdisp() : Container(child: Center(child: Text('search any keyword..'),),),
    );
  }
}
