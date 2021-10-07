import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:study_shelf/sceen/homepagereq.dart';
import 'package:study_shelf/sceen/process_uname.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        });
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
        icon: Icon(CupertinoIcons.back, size: 40, color: Colors.white),
          onPressed: () {
          //snapshotData.docs[index]['Subject'].clear();
          Navigator.push(context, MaterialPageRoute(builder: (context) => Homreq()));
          }),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_rounded),
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
                    icon: Icon(Icons.search_rounded, size: 26),
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
