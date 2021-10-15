import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_shelf/sceen/homepage.dart';
import 'package:study_shelf/sceen/selectpage.dart';
import 'package:study_shelf/sceen/process_uname.dart';

class Formp extends StatefulWidget {
  final String doc_id;
  final int value;
  const Formp({Key? key, required this.doc_id, required this.value}) : super(key: key);
  @override
  _FormpState createState() => _FormpState(doc_id, value);
}

class _FormpState extends State<Formp> {

  final title = TextEditingController();
  final captf = TextEditingController();
  final subop = TextEditingController();
  final ssubtag = TextEditingController();
  firebase_storage.UploadTask? task;
  File? file;

  String? valueDropmenu;
  List listpoint = ['pdf', 'png', 'jpg', 'jpeg'];

  late String doc_id;
  late int value;

  _FormpState(String doc_id, int value){
    this.doc_id = doc_id;
    this.value = value;
  }

  @override
  Widget build(BuildContext context) {
    final filename = file != null ? basename(file!.path) : 'No file selected';
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF1EEEE),
        appBar: AppBar(
          backgroundColor: const Color(0xFFC4B1DC),
          centerTitle: true,
          title: Text("Study Shelf", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Selectpg())),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 90, top: 20),
                child: Row(
                  children: [
                    Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(right: 15),
                      child: Icon(CupertinoIcons.paperclip, size: 26, color: const Color(0xFF585858), ),
                    ),
                    Text("Post your new notes..", style: TextStyle(fontSize: 18),),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Text('Insert file :', style: TextStyle(fontSize: 14),),
                      margin: EdgeInsets.only(top: 10, bottom: 10, right: 280),
                    ),
                    MaterialButton(
                      child: Container(
                        child: Icon(Icons.add, size: 50, color: const Color(0xFF585858),),
                        width: 80, height: 80,
                        decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: selectFile,
                    ),
                    Container(child: Text(filename,style: TextStyle(fontSize: 11)), margin: EdgeInsets.only(top: 4),),
                    Container(
                      child: Text('you can upload with format file : .pdf, .png, .jpg, .jpeg', style: TextStyle(fontSize: 11),),
                      margin: EdgeInsets.only(top: 20, bottom: 6, right: 80),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  border: Border.all(color: Color(0xFFAEAEAE)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButton(
                  hint: Text('Choose format..    '),
                  icon: Icon(Icons.arrow_drop_down_rounded),
                  value: valueDropmenu,
                  onChanged: (newValue) {
                    setState(() {
                      valueDropmenu = newValue as String?;
                    });
                  },
                  underline: SizedBox(),
                  items: listpoint.map((valueItem) {
                    return DropdownMenuItem(value: valueItem, child: Text('$valueItem'),);
                  }).toList(),
                ),
              ),
              Inpform(ttl: 'Title file :', r: 280, h: 33, cont: title,),
              Inpform(ttl: 'Subject option :', r: 240, h: 33, cont: captf,),
              Inpform(ttl: 'Caption file :', r: 260, h: 58, cont: subop,),
              Inpform(ttl: 'Sub-subject tag :', r: 235, h: 58, cont: ssubtag,),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  child: Text('Post', style: TextStyle(fontSize: 25, color: Colors.black),),
                  style: ElevatedButton.styleFrom(primary: Color(0xFFEFD1A9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                  onPressed: submitPost,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: (){
                  int point = 10;
                  getReward(point);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf']);
    if(result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
  }

  Future<String> uploadFile(File file) async {
    String filename = basename(file.path);
    firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    firebase_storage.Reference ref = storage.ref().child('upload/$filename');
    firebase_storage.UploadTask uploadTask = ref.putFile(file);
    await Future.value(uploadTask);
    var newurl = await ref.getDownloadURL();
    return newurl;
  }

  Future submitPost() async {
    if(file==null) return;
    var downloadurl = await uploadFile(file!);
    int point = value;
    content: getReward(point);
    content : fillPost(title.text, captf.text, subop.text, ssubtag.text, downloadurl, valueDropmenu!, doc_id);
    Navigator.push(this.context, MaterialPageRoute(builder: (context) => Home()));
  }
}

class Inpform extends StatelessWidget {
  final String ttl;
  final double r;
  final double h;
  final TextEditingController cont;
  const Inpform({
    Key? key, required this.ttl,
    required this.r, required this.h,
    required this.cont,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text(ttl, style: TextStyle(fontSize: 14),),
            margin: EdgeInsets.only(top: 10, bottom: 4, right: r,),
          ),
          Container(
            width: 335, height: h,
            padding: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(color: Colors.white30, border: Border.all(color: const Color(0xFFAEAEAE)), borderRadius: BorderRadius.circular(20)),
            child: TextField(
              controller: cont,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}

//for update reward
  Future getReward (int point) async {
    final firebase = FirebaseFirestore.instance;
    final pnrewrd = firebase.collection('Users').get();
    pnrewrd.then((QuerySnapshot docsnap) {
     docsnap.docs.forEach((doc) {
       int rwrd = doc['points'];
       int rewrd = rwrd+point;
       rewardUpdate(rewrd);
     });
    });
  }
  Future rewardUpdate(int points) async {
    final firebase = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    final updt = firebase.collection('Users').doc(uid).update({'points' : points});
  }