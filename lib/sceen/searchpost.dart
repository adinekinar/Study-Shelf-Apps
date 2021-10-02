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
    return Scaffold(
      appBar: AppBar(
        actions: [
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
          style: TextStyle(color: Colors.white30),
          decoration: InputDecoration(
            hintText: 'Search keyword..',
          ),
        ),
        backgroundColor: const Color(0xFFC4B1DC),
      ),
      body: isExecuted ? Streamkeypost() : Container(child: Center(child: Text('search any keyword..'),),),
    );
  }
}
