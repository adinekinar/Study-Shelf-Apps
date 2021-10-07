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
            body: Container(
              margin: EdgeInsets.only(left: 52, top: 130),
              child: Column(
                children: [
                  Text("Study Shelf", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 330,
                    height: 240,
                    decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Container(child: Text("Email :", style: TextStyle(fontSize: 18)), margin: EdgeInsets.only(right: 200, top: 20, bottom: 10),),
                        Container(
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
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                              child: Text('Reset Password', style: TextStyle(fontSize: 25),),
                              style: ElevatedButton.styleFrom(primary: Color(0xFFEFD1A9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                              onPressed: () async {
                                FirebaseAuth.instance.sendPasswordResetEmail(email: emailcont.text);
                                setState(() {
                                  Text('Please check the incoming message in your email.', style: TextStyle(fontSize: 14),);
                                  Text('Study Shelf have sent you an email to reset your password.', style: TextStyle(fontSize: 14),);
                                });
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 80, right: 85),
                          child: MaterialButton(
                            child: Row(
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
    );
}
}
