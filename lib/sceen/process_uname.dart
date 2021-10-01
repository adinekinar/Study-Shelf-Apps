import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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

Future<void> unameStore(String username) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  users.add({'username': username, 'uid': uid});
  return;
}

Future<void> fillPost (String title, String caption, String subject, String tag) async {
  CollectionReference fillp = FirebaseFirestore.instance.collection('FormPost');
  fillp.add({
    'Title': title,
    'Caption file': caption,
    'Subject': subject,
    'Sub-subject Tag': tag,
  });
  return;
}

class DatabaseReq {
  final CollectionReference fillr = FirebaseFirestore.instance.collection('FormRequest');

  Future<void> fillReq (String title, String caption, String subject, String tag, int point) async {
    fillr.add({
      'Title': title,
      'Caption request': caption,
      'Subject': subject,
      'Sub-subject Tag': tag,
      'Point Reward' : point,
    });
    return;
  }
}

class Streamkeyreq extends StatefulWidget {
  const Streamkeyreq({Key? key}) : super(key: key);

  @override
  _StreamkeyreqState createState() => _StreamkeyreqState();
}

class _StreamkeyreqState extends State<Streamkeyreq> {
  _StreamkeyreqState();
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
                            Container(
                              child: ElevatedButton(
                                child: Text(document['Subject'], style: TextStyle(fontSize: 13, color: const Color(0xFF585858)),),
                                style: ElevatedButton.styleFrom(primary: Color(0xFFCAB8E0).withOpacity(0.33), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: (Size(30, 25))),
                                onPressed: () {},
                              ),),
                            Container(child: Text(document['Sub-subject Tag']),),
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

class Streamkeypost extends StatefulWidget {
  const Streamkeypost({Key? key}) : super(key: key);

  @override
  _StreamkeypostState createState() => _StreamkeypostState();
}

class _StreamkeypostState extends State<Streamkeypost> {
  _StreamkeypostState();
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
                    width: 179, height: 280,
                    decoration: BoxDecoration(color: const Color(0xFFCAB8E0).withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Container(
                          width: 179, height: 161, decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
                        ),
                        Container(
                          child: ElevatedButton(
                            child: Text(document['Caption file'], style: TextStyle(fontSize: 13, color: const Color(0xFF585858)),),
                            style: ElevatedButton.styleFrom(primary: Color(0xFFCAB8E0).withOpacity(0.33), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: (Size(30, 25))),
                            onPressed: () {},
                          ),),
                        Container(child: Text(document['Sub-subject Tag']),),
                        Container(child: Text(document['Title'], style: TextStyle(fontSize: 16),),),
                        Container(child: Text('username'),),
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




