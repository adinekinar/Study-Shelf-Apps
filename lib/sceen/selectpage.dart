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
        body: Container(
          padding: EdgeInsets.all(10),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  child: Text('Post your new notes..', style: TextStyle(fontSize: 18, color: Colors.black),),
                  style: ElevatedButton.styleFrom(primary: Color(0xFFEFD1A9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: Size(double.infinity, 40)),
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Formp()));
                  }),
              ElevatedButton(
                  child: Text('Post your new notes request..', style: TextStyle(fontSize: 18, color: Colors.black),),
                  style: ElevatedButton.styleFrom(primary: Color(0xFFEFD1A9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: Size(double.infinity, 40)),
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Formq()));
                  }),
            ],
          ),
        ),
      ),),
    );
  }
}

