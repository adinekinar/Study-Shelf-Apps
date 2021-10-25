import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_shelf/sceen/eachpostpages.dart';
import 'package:study_shelf/sceen/homepage.dart';
import 'package:study_shelf/sceen/process_uname.dart';
import 'package:url_launcher/url_launcher.dart';

class subjectGroup extends StatelessWidget {
  final QuerySnapshot snapshotData;
  final String Subject;
  const subjectGroup({Key? key, required this.Subject, required this.snapshotData}) : super(key: key);

  @override

  Future<void> _launchInBrowser(String url, {bool forceWebView = false, bool enableJavaScript = false}) async {
    await launch(url);
  }

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
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
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
              child: MaterialButton(
                child: Container(
                  //margin: EdgeInsets.symmetric(horizontal: 15),
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
                      SizedBox(height:  15,),
                      Container(
                        child: ElevatedButton(
                          child: Text(snapshotData.docs[index]['Caption file'], style: TextStyle(fontSize: 13, color: const Color(0xFF585858)),),
                          style: ElevatedButton.styleFrom(primary: Color(0xFFCAB8E0).withOpacity(0.33), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: (Size(30, 25))),
                          onPressed: () {},
                        ),),
                      Container(child: Text('#'+snapshotData.docs[index]['Sub-subject Tag'], style: TextStyle(color: const Color(0xFF585858),),)),
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
                onPressed: () {Navigator.push(context,
                    MaterialPageRoute(builder: (context) => eachPost(Title: snapshotData.docs[index]['Title'], Url: snapshotData.docs[index]['url'], Format: snapshotData.docs[index]['File format'],
                        Caption: snapshotData.docs[index]['Subject'], Tag: snapshotData.docs[index]['Sub-subject Tag'], Uname: snapshotData.docs[index]['Username'], Subject: Subject, doc_id: snapshotData.docs[index].id)));},
              ),
            );
          }),
    );
  }
}


