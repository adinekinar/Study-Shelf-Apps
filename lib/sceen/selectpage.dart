import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:study_shelf/sceen/formpost.dart';
import 'package:study_shelf/sceen/formreq.dart';
import 'package:study_shelf/sceen/homepage.dart';

class Selectpg extends StatefulWidget {
  const Selectpg({Key? key}) : super(key: key);

  @override
  _SelectpgState createState() => _SelectpgState();
}

class _SelectpgState extends State<Selectpg> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        stops: [0.15, 0.56, 1.0],
        colors: [Color(0xFFC4B1DC), Color(0xFFDAD1E4), Color(0xFFEEEDEF)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: const Color(0xFFC4B1DC),
        centerTitle: true,
        title: Text("Study Shelf", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Home())),
        ),
      ),
        body: Column(
          children: [
            Container(margin: EdgeInsets.only(right: 270, top: 30),child: Text('Select One :', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(30),
              ),
              height: 230,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      child: Row(
                        children: [
                          Container(width: 60, height: 60, margin: EdgeInsets.only(top: 10, bottom: 10, right: 15), decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(60)),child: Icon(CupertinoIcons.paperclip, color: const Color(0xFF585858), size: 26,),),
                          Container(child: Text('Post your new notes..', style: TextStyle(fontSize: 18, color: Colors.black),)),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(primary: Color(0xFFEFD1A9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: Size(double.infinity, 40)),
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Formp(doc_id: '0', value: 10,)));
                      }),
                  ElevatedButton(
                      child: Row(
                        children: [
                          Container(width: 60, height: 60, margin: EdgeInsets.only(top: 10, bottom: 10, right: 15), decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(60)),child: Icon(Icons.paste_rounded, color: const Color(0xFF585858), size: 26,),),
                          Container(child: Text('Post your new notes request..', style: TextStyle(fontSize: 17, color: Colors.black))),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(primary: Color(0xFFEFD1A9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: Size(double.infinity, 40)),
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Formq()));
                      }),
                ],
              ),
            ),
          ],
        ),
      ),),
    );
  }
}

