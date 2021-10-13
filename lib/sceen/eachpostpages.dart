import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_shelf/sceen/homepage.dart';
import 'package:study_shelf/sceen/homepagereq.dart';
import 'package:study_shelf/sceen/pdfviewpage.dart';
import 'package:study_shelf/sceen/process_uname.dart';
import 'package:study_shelf/sceen/subjectgroup.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class FileApi {
  static Future<File> loadFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return storeFile(url,bytes);
  }
  static Future<File> storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes,flush: true);
    return file;
  }

}

class eachPost extends StatelessWidget {
  final String Title;
  final String Url;
  final String Format;
  final String Caption;
  final String Tag;
  final String Uname;
  final String Subject;
  final String doc_id;
  const eachPost({Key? key, required this.Title, required this.Url, required this.Format, required this.Caption, required this.Tag, required this.Uname, required this.Subject, required this.doc_id}) : super(key: key);

  Future<void> _launchInBrowser(String url, {bool forceWebView = false, bool enableJavaScript = false}) async {
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    late QuerySnapshot snapshotData;
    final bool isExecuted = true;
    final comment = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xFFF1EEEE),
      appBar: AppBar(
        title: Text(Title, style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: const Color(0xFFCAB8E0),
        leading: IconButton(
            icon: Icon(CupertinoIcons.back, size: 35, color: Colors.black),
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));}),
        actions: [
          IconButton(icon: Icon(Icons.download_rounded, color: const Color(0xFF585858),),
              onPressed: () async {
                _launchInBrowser(Url);
              }
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  MaterialButton(
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 30, bottom: 20),
                        height: 202, width: 267,
                        decoration: BoxDecoration(
                          color: Color((Format == 'pdf') ? (0xFFCAB8E0) : (0xFFFFFFFF)),
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage((Format == 'pdf') ?  'https://i.postimg.cc/VNTd9w2Q/PDF-File-Online-1-removebg-preview.png' : Url),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final file = await FileApi.loadFile(Url);
                      (Format == 'pdf') ? openPdf(context, file) : {};
                    },
                  ),
                  Container(child: Text(Title+' :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  Container(child: Text(Caption, style: TextStyle(fontSize: 20))),
                  Container(child: Text('tag : #'+Tag)),
                  ElevatedButton(
                    child: Text(Subject, style: TextStyle(
                    fontSize: 16, color: const Color(0xFF585858)),),
                    style: ElevatedButton.styleFrom(
                    primary: Color(0xFFCAB8E0).withOpacity(0.33),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                    minimumSize: (Size(50, 30))),
                    onPressed: () {}),
                  Text('Created by : '+Uname),
                  Container(height: 357.5),
                 ]
                ),
              Positioned.fill(
                child: DraggableScrollableSheet(
                    initialChildSize: 0.47,
                    maxChildSize: 0.55,
                    minChildSize: 0.47,
                    builder: (_, ScrollController){
                      return Container(
                        decoration: BoxDecoration(color: Color(0xFFF7F5F5), borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                        ),
                        child: Column(
                          children: [
                            Container(margin: EdgeInsets.only(top: 20, bottom: 7), child: Text('Comments', style: TextStyle(color: const Color(0xFF585858), fontSize: 20, fontWeight: FontWeight.bold),)),
                            Container(margin: EdgeInsets.only(bottom: 10), height: 7, width: 125, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFFCAB8E0)),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 5),
                                    width: 300, height: 50,
                                    padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(color: Colors.white30, border: Border.all(color: const Color(0xFFAEAEAE).withOpacity(0.2)), borderRadius: BorderRadius.circular(20)),
                                    child: TextField(controller: comment, decoration: InputDecoration(border: InputBorder.none, hintText: "Type your comment.."),)
                                ),
                                IconButton(
                                  icon: Icon(Icons.send_rounded, size: 30, color: const Color(0xFF585858),),
                                  onPressed: (){
                                    commentS('FormPost', doc_id, comment.text);
                                  },
                                ),
                              ],
                            ),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('FormPost').doc(doc_id).collection('Comments').snapshots(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if(!snapshot.hasData){
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Expanded(
                                  child: ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    controller: ScrollController,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot docsnapshot = snapshot.data!.docs[index];
                                      return Container(
                                        padding: EdgeInsets.all(20),
                                        margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE9E3EB),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child : Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(docsnapshot['Username']+' :', style: TextStyle(color: Color(0xFF585858),)),
                                            Text(docsnapshot['Context comment']),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ),
            ],
          )
          ),
      ),
      );
  }
}

void openPdf(BuildContext context, File file) => Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => pdfViewerpage(file: file))
);

class eachReq extends StatelessWidget {
  final String Title;
  final String Caption;
  final String Tag;
  final String Uname;
  final String Subject;
  final String doc_id;
  const eachReq({Key? key, required this.Title, required this.Caption, required this.Tag, required this.Uname, required this.Subject, required this.doc_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comment = TextEditingController();
    return Scaffold(
          backgroundColor: const Color(0xFFF1EEEE),
          appBar: AppBar(
          title: Text(Title, style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: const Color(0xFFCAB8E0),
        leading: IconButton(
        icon: Icon(CupertinoIcons.back, size: 35, color: Colors.black),
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Homreq()));}),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Stack(
              children: <Widget>[
                Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 30, bottom: 20),
                          height: 150, width: 150,
                          decoration: BoxDecoration(
                            color: const Color(0xFFCAB8E0),
                            borderRadius: BorderRadius.circular(20),
                            ),
                          child: Icon(Icons.paste_rounded, color: const Color(0xFF585858), size: 80,),
                          ),
                        ),
                      Container(child: Text(Title+' :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                      Align(alignment: Alignment.center,child: Text(Caption, style: TextStyle(fontSize: 20))),
                      Container(child: Text('tag : #'+Tag)),
                      ElevatedButton(
                          child: Text(Subject, style: TextStyle(
                              fontSize: 16, color: const Color(0xFF585858)),),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFCAB8E0).withOpacity(0.33),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              minimumSize: (Size(50, 30))),
                          onPressed: () {}),
                      Text('Request by : '+Uname),
                      Container(height: 410),
                    ]
                ),
                Positioned.fill(
                  child: DraggableScrollableSheet(
                      initialChildSize: 0.53,
                      maxChildSize: 0.6,
                      minChildSize: 0.53,
                      builder: (_, ScrollController){
                        return Container(
                          decoration: BoxDecoration(color: Color((0xFFF7F5F5)), borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                          ),
                          child: Column(
                            children: [
                              Container(margin: EdgeInsets.only(top: 20, bottom: 7), child: Text('Comments', style: TextStyle(color: const Color(0xFF585858), fontSize: 20, fontWeight: FontWeight.bold),)),
                              Container(margin: EdgeInsets.only(bottom: 10), height: 7, width: 125, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFFCAB8E0)),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 5),
                                      width: 300, height: 50,
                                      padding: EdgeInsets.only(left: 20),
                                      decoration: BoxDecoration(color: Colors.white30, border: Border.all(color: const Color(0xFFAEAEAE).withOpacity(0.2)), borderRadius: BorderRadius.circular(20)),
                                      child: TextField(controller: comment, decoration: InputDecoration(border: InputBorder.none, hintText: "Type your comment.."),)
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.send_rounded, size: 30, color: const Color(0xFF585858),),
                                    onPressed: (){
                                      commentS('FormRequest', doc_id, comment.text);
                                    },
                                  ),
                                ],
                              ),
                              StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('FormRequest').doc(doc_id).collection('Comments').snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if(!snapshot.hasData){
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Expanded(
                                    child: ListView.builder(
                                      controller: ScrollController,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot docsnapshot = snapshot.data!.docs[index];
                                        return Container(
                                          padding: EdgeInsets.all(20),
                                          margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE9E3EB),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child : Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(docsnapshot['Username']+' :', style: TextStyle(color: Color(0xFF585858),)),
                                              Text(docsnapshot['Context comment']),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                              ),
                            ],
                          ),
                        );
                      }
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}

Future<void> commentS (String maincollection, String doc_id, String com) async {
  DocumentReference cmnt = FirebaseFirestore.instance.collection(maincollection).doc(doc_id).collection('Comments').doc();
  FirebaseAuth auth = FirebaseAuth.instance;
  String username = auth.currentUser!.displayName.toString();
  cmnt.set({
    'Context comment' : com,
    'Username' : username,
  });
  return;
}