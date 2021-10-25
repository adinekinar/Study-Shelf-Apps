import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:study_shelf/sceen/homepagereq.dart';
import 'package:study_shelf/sceen/loginpage.dart';
import 'package:study_shelf/sceen/meeting.dart';
import 'package:study_shelf/sceen/navbar.dart';
import 'package:study_shelf/sceen/process_uname.dart';
import 'package:study_shelf/sceen/searchpost.dart';
import 'package:study_shelf/sceen/selectpage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAscending = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
        floatingActionButton: FloatingActionButton(onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Selectpg()),);},
          child: const Icon(Icons.add, color: const Color(0xFF585858),size: 35,),
          backgroundColor: const Color(0xFFEFD1A9),
        ),
      backgroundColor: const Color(0xFFF1EEEE),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black,size:50),
        centerTitle: true,
        title: Text('Study Shelf', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: const Color(0xFFC4B1DC),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded, size: 35, color: Colors.black),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => searchPostpages()))
          ),
          MaterialButton(
            child: Image.network('https://i.postimg.cc/Pq2ZWTHF/Webcam.png', width: 35, height: 35,),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Meeting())),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            //alignment: Alignment(30,81),
            width: MediaQuery.of(context).size.width, height: 53,
            decoration: BoxDecoration(
              color: const Color(0xFFA386C8),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child:Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 14,top: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text("Posting", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                        ),
                        Container(
                          width: 185, height: 5,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFD1A9),
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ],
                    ),
                  ),
                Container(
                  margin: EdgeInsets.only(left: (MediaQuery.of(context).size.width/29)),
                  width: 1,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E5E5),
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Homreq()));
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width/2.55), height: 55,
                    margin: EdgeInsets.only(left: 14,top: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Center(
                    child: Text("Request", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                  ),
                      ],
                  ),
              ),
              ),
            ],
            ),
          ),
          Expanded(child: Container(child: Streamkeypost())),
        ],
      ),
    );
  }
}