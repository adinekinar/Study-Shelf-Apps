import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:study_shelf/sceen/process_uname.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class searchPostpages extends StatefulWidget {
  const searchPostpages({Key? key}) : super(key: key);

  @override
  _searchPostpagesState createState() => _searchPostpagesState();
}

class _searchPostpagesState extends State<searchPostpages> {
  final searchcont = TextEditingController();
  late QuerySnapshot snapshotData;
  bool isExecuted = false;
  @override
  Widget build(BuildContext context) {

    Widget searchdisp() {
      return GridView.builder(
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
                  Container(child: Text('username'),),
                ],
              ),
            ),
          );
        });
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        actions: [
          IconButton(
          icon: Icon(Icons.clear_rounded),
          onPressed: () {
            searchcont.clear();
            setState(() {
              isExecuted = false;
            });
          },),
          GetBuilder<DatacontPost>(
              init: DatacontPost(),
              builder: (val) {
                return IconButton(
                    icon: Icon(Icons.search_rounded, size: 26),
                    onPressed: () {
                      val.Searchpost(searchcont.text).then((value) {
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
