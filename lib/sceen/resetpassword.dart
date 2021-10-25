import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_shelf/sceen/loginpage.dart';

class PassReset extends StatefulWidget {
  const PassReset({Key? key}) : super(key: key);

  @override
  _PassResetState createState() => _PassResetState();
}

class _PassResetState extends State<PassReset> {
  final emailcont = TextEditingController();
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
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/7.5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network('https://i.postimg.cc/cCfWFLX9/Book-Shelf.png', height: 20, width: 20,),
                          Text("Study Shelf", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 43),
                        width: MediaQuery.of(context).size.width-100,
                        height: MediaQuery.of(context).size.height/3,
                        decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Container(child: Text("Email :", style: TextStyle(fontSize: 18))),
                            SizedBox(height: 10,),
                            Center(
                              child: Container(
                                padding: EdgeInsets.only(left: 20),
                                width: 254, height: 52,
                                decoration: BoxDecoration(
                                    color: Colors.white30,
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextField(
                                  controller: emailcont,
                                  decoration: InputDecoration(hintText: 'Input Email..', icon: Icon(Icons.email, size: 24), border: InputBorder.none),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: ElevatedButton(
                                    child: Text('Reset Password', style: TextStyle(fontSize: 25),),
                                    style: ElevatedButton.styleFrom(primary: Color(0xFFEFD1A9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                                    onPressed: () async {
                                      FirebaseAuth.instance.sendPasswordResetEmail(email: emailcont.text);
                                      setState(() {
                                        showDialog(context: context, builder: (BuildContext context){
                                          return AlertDialog(
                                            title: Center(child: Text('Please check your email', style: TextStyle(color: Colors.black))),
                                            content: Text('Study Shelf have sent you an email for reset your password.', style: TextStyle(color: Colors.black)),
                                          );
                                        });
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SSlogin()));
                                      });
                                    }),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Align(
                              alignment: Alignment.center,
                              child: MaterialButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.back),
                                    Text('Back to Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),),
                                  ],
                                ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SSlogin()));
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
}
}
