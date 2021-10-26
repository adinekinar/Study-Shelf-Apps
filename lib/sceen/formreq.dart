import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_shelf/sceen/homepagereq.dart';
import 'package:study_shelf/sceen/selectpage.dart';
import 'package:study_shelf/sceen/process_uname.dart';

class Formq extends StatefulWidget {
  const Formq({Key? key}) : super(key: key);

  @override
  _FormqState createState() => _FormqState();
}

class _FormqState extends State<Formq> {
  final title = TextEditingController();
  final captf = TextEditingController();
  final subop = TextEditingController();
  final ssubtag = TextEditingController();
  late bool isVisible = true;

  String? valueDropmenu;
  int? value;
  List listpoint = ['5','10','15','20','25'];
  late int index;


  @override
  Widget build(BuildContext context) {
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
          actions: [
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot>snapshot) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image.network('https://i.postimg.cc/CMsRMRhk/badge.png',width: 20,height: 20,),
                        Text((snapshot.data!['points']).toString(), style: TextStyle(color: const Color(0xFF585858), fontSize: 20),),
                      ],
                    ),
                  );
                }
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(right: 15),
                      child: Icon(Icons.paste_rounded, size: 26, color: const Color(0xFF585858), ),
                    ),
                    Text("Post your new notes request..", style: TextStyle(fontSize: 18),),
                  ],
                ),
              ),
              Inpform(ttl: 'Title request :', h: MediaQuery.of(context).size.height/20, cont: title,),
              Inpform(ttl: 'Subject option :', h: MediaQuery.of(context).size.height/20, cont: subop,),
              Inpform(ttl: 'Caption request :', h: MediaQuery.of(context).size.height/12, cont: captf,),
              Inpform(ttl: 'Sub-subject tag :', h: MediaQuery.of(context).size.height/20, cont: ssubtag,),
              SizedBox(height: 10,),
              Container(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/9),child: Text("Total Reward to Give :")),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          border: Border.all(color: Color(0xFFAEAEAE)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                          builder: (context, AsyncSnapshot<DocumentSnapshot>snapshot) {
                            return DropdownButton(
                              hint: Text('Choose point..    '),
                              icon: Icon(Icons.arrow_drop_down_rounded),
                              value: valueDropmenu,
                              onChanged: (newValue) {
                                setState(() {
                                  valueDropmenu = newValue as String?;
                                  if(int.parse(newValue!)>snapshot.data!['points']){
                                    isVisible = false;
                                    showDialog(context: context, builder: (BuildContext context){
                                    return AlertDialog(
                                    title: Text('Your Point not Enough', style: TextStyle(color: Colors.red)),
                                    content: Text('Choose point for reward again!', style: TextStyle(color: Colors.red)),
                                    );
                                  });}
                                  else if (int.parse(newValue)==snapshot.data!['points']){
                                    isVisible = true;
                                  }
                                });
                              },
                              underline: SizedBox(),
                              items: (listpoint).map((valueItem) {
                                return DropdownMenuItem(value: valueItem, child: Text('$valueItem points'),);
                            }).toList(),
                            );
                          }
                        ),
                      ),
              ),
              Center(
                child: Visibility(
                  visible: isVisible,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      child: Text('Request', style: TextStyle(fontSize: 25, color: Colors.black),),
                      style: ElevatedButton.styleFrom(primary: Color(0xFFEFD1A9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                      onPressed: () async {
                        value = int.parse(valueDropmenu!);
                        content: getReward(value!);
                        content: DatabaseReq().fillReq(title.text, captf.text, subop.text, ssubtag.text, value!);
                        Navigator.push(this.context, MaterialPageRoute(builder: (context) => Homreq()));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //get Reward
  Future getReward (int point) async {
    final firebase = FirebaseFirestore.instance;
    final pnrewrd = firebase.collection('Users').get();
    pnrewrd.then((QuerySnapshot docsnap) {
      docsnap.docs.forEach((doc) {
        int rwrd = doc['points'];
        int rewrd = rwrd-point;
          rewardUpdate(rewrd);
        });
      });
    }
  }
  Future rewardUpdate(int points) async {
    final firebase = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    final updt = firebase.collection('Users').doc(uid).update({'points' : points});
  }

class Inpform extends StatelessWidget {
  final String ttl;
  final double h;
  final TextEditingController cont;
  const Inpform({
    Key? key, required this.ttl,
    required this.h,
    required this.cont,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/9),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(ttl, style: TextStyle(fontSize: 14),),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: double.infinity, height: h,
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



//snapshot.data!['points']<listpoint ? listpoint :