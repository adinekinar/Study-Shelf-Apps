import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  Future getdbReq() async{
    List itemlist =[];
    try{
      var fillr;
      await fillr.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element){
          itemlist.add(element.data);
        });
      });
      return itemlist;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}



