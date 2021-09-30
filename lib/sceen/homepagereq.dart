import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:study_shelf/sceen/homepage.dart';
import 'package:study_shelf/sceen/loginpage.dart';
import 'package:study_shelf/sceen/process_uname.dart';
import 'package:study_shelf/sceen/selectpage.dart';

class Homreq extends StatefulWidget {
  const Homreq({Key? key}) : super(key: key);

  @override
  _HomreqState createState() => _HomreqState();
}

class _HomreqState extends State<Homreq> {
  List requestList = [];
  @override
  void initState() {
    super.initState();
    fetchDatabaselist();
  }

  fetchDatabaselist () async {
    dynamic result = await DatabaseReq().getdbReq();
    if(result == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        requestList = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              MaterialButton(
                child: Image.network('https://i.postimg.cc/Pq2ZWTHF/Webcam.png'),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SSlogin())),
              ),
            ],
            leading: IconButton(
            icon: Icon(Icons.view_headline_rounded, size: 40, color: Colors.black),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SSlogin())),
            ),
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
            Expanded(
                  child: ListView.builder(
                      itemCount: requestList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(requestList[index]['title']),
                            subtitle: Text(requestList[index]['caption']),
                            leading: Container(decoration: BoxDecoration(color: const Color(0xFFCAB8E0), borderRadius: BorderRadius.circular(25)),child: Icon(Icons.paste_rounded, size: 26, color: const Color(0xFF585858),)),
                            trailing: Text(requestList[index]['tag']),
                          ),
                        );
                      }
                    ),
                ),
          ],
        ),
    );
  }
}
