import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_shelf/sceen/subjectgroup.dart';
import 'package:study_shelf/sceen/formpost.dart';
import 'package:study_shelf/sceen/subjectgroupreq.dart';
import 'package:url_launcher/url_launcher.dart';

//api submit file
class FirebaseApi {
  static UploadTask? submitPost(String dest, File file) {
    try{
      final ref = FirebaseStorage.instance.ref(dest);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}

//for get uid for username from auth
Future<void> unameStore(String username) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  users.add({'username': username, 'uid': uid});
  return;
}

//for store data post
Future<void> fillPost (String title, String caption, String subject, String tag, url, String format) async {
  CollectionReference fillp = FirebaseFirestore.instance.collection('FormPost');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  String username = auth.currentUser!.displayName.toString();
  fillp.add({
    'File format' : format,
    'Title': title,
    'Caption file': caption,
    'Subject': subject,
    'Sub-subject Tag': tag,
    'uid' : uid,
    'Username' : username,
    'url' : url,
  });
  return;
}

class DatabaseReq {
  final CollectionReference fillr = FirebaseFirestore.instance.collection('FormRequest');

  Future<void> fillReq (String title, String caption, String subject, String tag, int point) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    String username = auth.currentUser!.displayName.toString();
    fillr.add({
      'Title': title,
      'Caption request': caption,
      'Subject': subject,
      'Sub-subject Tag': tag,
      'Point Reward' : point,
      'uid' : uid,
      'Username' : username,
    });
    return;
  }
}

//display data request
class Streamkeyreq extends StatefulWidget {
  const Streamkeyreq({Key? key}) : super(key: key);

  @override
  _StreamkeyreqState createState() => _StreamkeyreqState();
}

class _StreamkeyreqState extends State<Streamkeyreq> {
  _StreamkeyreqState();
  late QuerySnapshot snapshotData;
  bool isExecuted = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('FormRequest').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
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
                            Container(margin: EdgeInsets.only(top: 15), child: Text(document['Title'])),
                            Container(child: Text(document['Caption request']),),
                            GetBuilder <GroupReq> (
                              init: GroupReq(),
                              builder: (val) {
                                return ElevatedButton(
                                  child: Text(document['Subject'], style: TextStyle(fontSize: 13, color: const Color(0xFF585858)),),
                                  style: ElevatedButton.styleFrom(primary: Color(0xFFCAB8E0).withOpacity(0.33), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: (Size(30, 25))),
                                  onPressed: () {
                                    val.GrReq(document['Subject']).then((value) {
                                      snapshotData = value;
                                      setState(() {
                                        isExecuted = true;
                                      });
                                    });
                                    isExecuted ? Navigator.push(context, MaterialPageRoute(builder: (context) => subjectGroupreq(Subject : document['Subject'], snapshotData: snapshotData,))) : {};
                                  },
                                );
                              },),
                            Container(child: Text('#'+document['Sub-subject Tag']),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

//display data post
class Streamkeypost extends StatefulWidget {
  const Streamkeypost({Key? key}) : super(key: key);

  @override
  _StreamkeypostState createState() => _StreamkeypostState();
}

class _StreamkeypostState extends State<Streamkeypost> {
  _StreamkeypostState();
  late String _fileFullPath;
  late Dio dio;
  late QuerySnapshot snapshotData;
  late String progress;
  bool isExecuted = true;
  bool isLoading=false;
  //@override
  /*void initState() {
    dio = Dio();
    super.initState();
  }*/

  /*Future <List<Directory>?> _getExternalStoragePath() {
    return p.getExternalStorageDirectories(type: p.StorageDirectory.documents);
  }*/

  /*Future _downloadStorage(String urlp, String filename) async {
    try{
      final dirList = await p.getApplicationDocumentsDirectory();
      final path = dirList.path;
      final file = File('$path/$filename');
      await dio.download(urlp, file.path, onReceiveProgress: (rec, total) {
        setState(() {
          isLoading = true;
          progress = ((rec/total)* 100).toStringAsFixed(0)+"%";
          print(progress);
        });
      });
      _fileFullPath = file.path;
    }catch(e) {
      print(e);
    }
  }*/

  Future<void> _launchInBrowser(String url, {bool forceWebView = false, bool enableJavaScript = false}) async {
    await launch(url);
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('FormPost').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.count(
              childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height),
              crossAxisCount: 2,
              children: snapshot.data!.docs.map((document) {
                return Center(
                  child: Container(
                    width: 179, height: 370,
                    decoration: BoxDecoration(color: const Color(0xFFCAB8E0).withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Container(
                          width: 179, height: 190,
                          decoration: BoxDecoration(
                            color: Color((document['File format'] == 'pdf') ? (0xFFCAB8E0) : (0xFFFFFFFF)),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                            image: DecorationImage(
                              image: NetworkImage((document['File format'] == 'pdf') ?  'https://i.postimg.cc/VNTd9w2Q/PDF-File-Online-1-removebg-preview.png' : document['url']),
                            ),
                          ),
                        ),
                        GetBuilder<GroupPost> (
                          init: GroupPost(),
                          builder: (val) {
                            return Container(
                             margin: EdgeInsets.only(top: 20),
                             child: ElevatedButton(
                              child: Text(document['Caption file'], style: TextStyle(fontSize: 13, color: const Color(0xFF585858)),),
                              style: ElevatedButton.styleFrom(primary: Color(0xFFCAB8E0).withOpacity(0.33), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: (Size(30, 25))),
                              onPressed: () {
                                val.GrPost(document['Caption file']).then((value) {
                                snapshotData = value;
                              });
                                isExecuted ? Navigator.push(context, MaterialPageRoute(builder: (context) => subjectGroup(Subject : document['Caption file'], snapshotData: snapshotData,))) : {};
                              }
                            ));
                          },
                        ),
                        Container(child: Text('#'+document['Sub-subject Tag']),),
                        Container(child: Text(document['Title'], style: TextStyle(fontSize: 18),),),
                        Container(child: Text(document['Username']),),
                        IconButton(icon: Icon(Icons.download_rounded, color: const Color(0xFF585858),),
                            onPressed: () async {
                              await _launchInBrowser(document['url']);
                            }
                        ),
                      ],
                    ),
                  ),
               );
            }).toList(),
          );
        },
      ),
    );
  }
}

//Searching post
class DatacontPost extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }
  Future Searchpost(String qStringpost) async {
    return FirebaseFirestore.instance.collection('FormPost').where('Title', isGreaterThanOrEqualTo: qStringpost.substring(0,1).toUpperCase()).get();
  }
}

//Searching request
class DatacontReq extends GetxController {
  Future getDatareq(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }
  Future Searchreq(String qStringreq) async {
    return FirebaseFirestore.instance.collection('FormRequest').where('Title', isGreaterThanOrEqualTo: qStringreq.substring(0,1).toUpperCase()).get();
  }
}

//Group Reguest
class GroupReq extends GetxController {
  Future getGrReq(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }
  Future GrReq(String Subject) async {
    return FirebaseFirestore.instance.collection('FormRequest').where('Subject', isEqualTo: Subject).get();
  }
}

//Group Post
class GroupPost extends GetxController {
  Future getGrPost(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }
  Future GrPost(String Subject) async {
    return FirebaseFirestore.instance.collection('FormPost').where('Caption file', isEqualTo: Subject).get();
  }
}