import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:study_shelf/sceen/homepage.dart';
import 'package:study_shelf/sceen/loginpage.dart';
import 'package:study_shelf/sceen/navbar.dart';
import 'package:study_shelf/sceen/process_uname.dart';
import 'package:study_shelf/sceen/searchreq.dart';
import 'package:study_shelf/sceen/selectpage.dart';

class Homreq extends StatefulWidget {
  const Homreq({Key? key}) : super(key: key);

  @override
  _HomreqState createState() => _HomreqState();
}

class _HomreqState extends State<Homreq> {
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
            centerTitle: true,
            title: Text('Study Shelf', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            backgroundColor: const Color(0xFFC4B1DC),
            actions: [
              IconButton(
                  icon: Icon(Icons.search_rounded, size: 42, color: Colors.black),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => searchReqpages()))
              ),
              MaterialButton(
                child: Image.network('https://i.postimg.cc/Pq2ZWTHF/Webcam.png'),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SSlogin())),
              ),
            ],
          ),
        body: Column(
          children: [
            Container(
              width: 445, height: 53,
              decoration: BoxDecoration(
                color: const Color(0xFFA386C8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            child: Row(
              children: [
                MaterialButton(
                  onPressed: () async {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home()));
                  },
                child: Container(
                  width: 162, height: 55,
                  margin: EdgeInsets.only(left: 9,top: 13),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Text("Posting", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
                      ),
                    ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 9),
                  width: 1,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E5E5),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 23,top: 13),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Text("Request", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),),
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
              ],
            )
            ),
            Expanded(child: Container(child: Streamkeyreq())),
          ],
        ),
    );
  }
}

class listRequested extends StatelessWidget {

  String? title, caption, subject, tag;
  listRequested(this.title, this.caption, this.subject, this.tag);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Container(
        margin: EdgeInsets.all(10),
        width: 372, height: 117,
        decoration: BoxDecoration(color: const Color(0xFFCAB8E0).withOpacity(0.2), borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            Container(width: 75, height: 75, margin: EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFCAB8E0), borderRadius: BorderRadius.circular(25)),child: Icon(Icons.paste_rounded, size: 26, color: const Color(0xFF585858),)),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(child: Text(title!, style: TextStyle(fontSize: 13, color: Colors.black),textAlign: TextAlign.left,)),
                  Container(child: Text(caption!, style: TextStyle(fontSize: 12, color: const Color(0xFF585858)),)),
                  Container(
                    child: ElevatedButton(
                      child: Text(subject!, style: TextStyle(fontSize: 13, color: const Color(0xFF585858)),),
                      style: ElevatedButton.styleFrom(primary: Color(0xFFCAB8E0).withOpacity(0.33), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), minimumSize: (Size(30, 25))),
                      onPressed: () {},
                    ),),
                  Container(child: Text(tag!, style: TextStyle(fontSize: 13, color: const Color(0xFF585858)),),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
