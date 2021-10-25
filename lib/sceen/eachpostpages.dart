import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_shelf/sceen/formpost.dart';
import 'package:study_shelf/sceen/homepage.dart';
import 'package:study_shelf/sceen/homepagereq.dart';
import 'package:study_shelf/sceen/pdfviewpage.dart';
import 'package:study_shelf/sceen/postreplay.dart';
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

//Post
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 30, bottom: 20),
                        width: MediaQuery.of(context).size.width/1.5, height: MediaQuery.of(context).size.height/4,
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
                    onLongPress: () async {
                      infoPopUp(context);
                    },
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(child: Text(Title+' :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                        Container(child: Text(Caption, style: TextStyle(fontSize: 20))),
                        SizedBox(height: 15,),
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
                        Align(alignment: Alignment.centerRight,child: Text('Created by : '+Uname)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
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
  Future infoPopUp (BuildContext context) => showDialog (
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('FileInformation').where('fileurl' ,isEqualTo: Url).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            return Container(
              padding: EdgeInsets.all(30),
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Icon(Icons.info_outline_rounded, size: 50, color: const Color(0xFF585858),)),
                  //Text(snapshot.data!.docs[0]['namefile']),
                  SizedBox(height: 15,),
                  Text('name file :'+snapshot.data!.docs[0]['filename']),
                  SizedBox(height: 5,),
                  Text('Size file :'+snapshot.data!.docs[0]['filesize'].toString()+'Byte'),
                  SizedBox(height: 5,),
                  Text('Extension file :'+snapshot.data!.docs[0]['extension']),
                  SizedBox(height: 5,),
                  Text('Path file :'+snapshot.data!.docs[0]['filepath']),
                ],
              ),
            );
          }
        ),
      );
    }
  );
}

void openPdf(BuildContext context, File file) => Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => pdfViewerpage(file: file))
);

//Request
class eachReq extends StatelessWidget {
  final String Title;
  final String Caption;
  final String Tag;
  final String Uname;
  final String Subject;
  final String doc_id;
  final int value;
  eachReq({Key? key, required this.Title, required this.Caption, required this.Tag, required this.Uname, required this.Subject, required this.doc_id, required this.value}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    final comment = TextEditingController();
    late QuerySnapshot snapshotData;
    bool solved;
    return  Scaffold(
            floatingActionButton: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('FormPost').doc(doc_id).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot>snapshot) {
                return FloatingActionButton(
                  child: const Icon(Icons.reply_rounded, color: const Color(0xFF585858),size: 35,),
                  backgroundColor: const Color(0xFFEFD1A9),
                  onPressed: () async {
                    (snapshot.data!.exists) ? Navigator.push(context, MaterialPageRoute(builder: (context) => postReplay(doc_id: doc_id))) : Navigator.push(context, MaterialPageRoute(builder: (context) => Formp(doc_id: doc_id,value: value,)));
                  },
                );
              }
            ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 30, bottom: 20),
                              width: MediaQuery.of(context).size.width/2.5, height: MediaQuery.of(context).size.height/5.2,
                              decoration: BoxDecoration(
                                color: const Color(0xFFCAB8E0),
                                borderRadius: BorderRadius.circular(20),
                                ),
                              child: Icon(Icons.paste_rounded, color: const Color(0xFF585858), size: 80,),
                              ),
                            ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                           child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Title+' :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Container(child: Text(Caption, style: TextStyle(fontSize: 20))),
                              SizedBox(height: 8,),
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
                              Align(alignment: Alignment.centerRight,child: Text('Request by : '+Uname)),
                            ],
                          )),
                          SizedBox(height: 20,),
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
                                        onPressed: () async {
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

//comment
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

//nyoba 2
Future getSolved () async {
  final firebase = FirebaseFirestore.instance;
  final pnrewrd = firebase.collection('FormPost').get();
  String id;
  pnrewrd.then((QuerySnapshot docsnap) {
    docsnap.docs.forEach((doc) {
      id = doc['docid'];
      print(id);
    });
  });
}
String prnt (String n) {
  return n;
}

//nyoba 1
Future solvedOrno (String docidrequest) async {
  final firsol =  FirebaseFirestore.instance.collection('FormPost').where('docid' == docidrequest).get();
  firsol.then((QuerySnapshot docsnap) {
    docsnap.docs.forEach((doc) {
      String n = doc['docid'];
      prnts(n);
    });
  });
}
String prnts (String n) {
  return n;
}

int index (int length) {
  int i = 0;
  if(i==0)
    i++;
  if(i<length)
    i++;
  return i;
}

//solvedOrno(doc_id) ? subjectGroup(Subject: ' ', snapshotData: snapshotData) :