import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:study_shelf/sceen/process_uname.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_shelf/sceen/subjectgroup.dart';
import 'package:study_shelf/sceen/subjectgroupreq.dart';
import 'package:url_launcher/url_launcher.dart';

import 'homepage.dart';

class searchPostpages extends StatefulWidget {
  const searchPostpages({Key? key}) : super(key: key);

  @override
  _searchPostpagesState createState() => _searchPostpagesState();
}

class _searchPostpagesState extends State<searchPostpages> {
  final searchcont = TextEditingController();
  late QuerySnapshot snapshotData;
  bool isExecuted = false;

  Future<void> _launchInBrowser(String url, {bool forceWebView = false, bool enableJavaScript = false}) async {
    await launch(url);
  }

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
              margin: EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.of(context).size.width/1.2, height: MediaQuery.of(context).size.height/2.17,
              decoration: BoxDecoration(color: const Color(0xFFCAB8E0).withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/1.2, height: MediaQuery.of(context).size.height/4.15, decoration: BoxDecoration(color: Color((snapshotData.docs[index]['File format'] == 'pdf') ? (0xFFCAB8E0) : (0xFFFFFFFF)), borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                        image: DecorationImage(
                        image: NetworkImage((snapshotData.docs[index]['File format'] == 'pdf') ?  'https://i.postimg.cc/VNTd9w2Q/PDF-File-Online-1-removebg-preview.png' : snapshotData.docs[index]['url']),
                      ),
                    ),
                  ),
                  GetBuilder<GroupPost> (
                    init: GroupPost(),
                    builder: (val) {
                      return Container(
                          margin: EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                              child: Text(snapshotData.docs[index]['Caption file'], style: TextStyle(fontSize: 13, color: const Color(0xFF585858)),),
                              style: ElevatedButton.styleFrom(primary: Color(0xFFCAB8E0).withOpacity(0.33), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: (Size(30, 25))),
                              onPressed: () { (snapshotData != null) ?
                              val.GrPost(snapshotData.docs[index]['Caption file']).then((value) {
                                snapshotData = value;
                                snapshotData.docs[index]['Caption file'].clear();
                              }): (snapshotData = snapshotData.docs[index]['Caption file']);
                              isExecuted ? Navigator.push(context, MaterialPageRoute(builder: (context) => subjectGroup(Subject : snapshotData.docs[index]['Caption file'], snapshotData: snapshotData,))) : {};
                              }
                          ));
                    },
                  ),
                  Container(child: Text('#'+snapshotData.docs[index]['Sub-subject Tag'], style: TextStyle(color: const Color(0xFF585858)),),),
                  Container(child: Text(snapshotData.docs[index]['Title'], style: TextStyle(fontSize: 18),),),
                  Container(child: Text(snapshotData.docs[index]['Username']),),
                  IconButton(icon: Icon(Icons.download_rounded, color: const Color(0xFF585858),),
                      onPressed: () async {
                        await _launchInBrowser(snapshotData.docs[index]['url']);
                      }
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
           }),
        actions: [
          IconButton(
          icon: Icon(Icons.clear_rounded, color: Colors.black,),
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
                    icon: Icon(Icons.search_rounded, size: 26, color: Colors.black,),
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