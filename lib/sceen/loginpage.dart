import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_shelf/sceen/homepage.dart';
import 'package:study_shelf/sceen/registerpage.dart';

class SSlogin extends StatefulWidget {
  const SSlogin({Key? key}) : super(key: key);

  @override
  _SSloginState createState() => _SSloginState();
}

class _SSloginState extends State<SSlogin> {
  final emailcnt = TextEditingController();
  final passcnt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

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
          child: Container(
            margin: EdgeInsets.only(left: 52, top: 130),
            child: Column(
            children: [
              Text("Study Shelf", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              Container(
               margin: EdgeInsets.only(top: 20),
               width: 330,
               height: 468,
               decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Container(
                    child: Text("LOGIN", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),textAlign: TextAlign.center,),
                    margin: EdgeInsets.only(top: 20),
                  ),
                  Container(child: Text("Email :", style: TextStyle(fontSize: 18)), margin: EdgeInsets.only(right: 200, top: 5, bottom: 10),),
                  Container(
                    width: 254,
                    height: 52,
                    decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                            controller: emailcnt,
                            decoration: InputDecoration(hintText: 'Input Email..', icon: Icon(Icons.email, size: 24), border: InputBorder.none),
                          ),
                  ),
                  Container(child: Text("Password :", style: TextStyle(fontSize: 18),textAlign: TextAlign.left,),margin: EdgeInsets.only(top: 10, right: 165, bottom: 10),),
                  Container(
                    width: 254,
                    height: 52,
                    decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      controller: passcnt,
                      decoration: InputDecoration(hintText: 'Input Password..', icon: Icon(Icons.vpn_key, size: 24), border: InputBorder.none),
                    ),
                  ),
                  Container(
                    child: MaterialButton(child: Text('Forgot password?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),),
                      onPressed: () {},
                    ),
                    margin: EdgeInsets.only(left: 105),
                  ),
                  ElevatedButton(
                      child: Text('Login', style: TextStyle(fontSize: 25),),
                      style: ElevatedButton.styleFrom(primary: Color(0xFFEFD1A9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                      onPressed: () async {
                        content : await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcnt.text, password: passcnt.text);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                        setState(() {});
                      }),
                  Container(child: Text('Haven’t account?', style: TextStyle(fontSize: 18),), margin: EdgeInsets.only(top: 10, bottom: 10),),
                  ElevatedButton(
                      child: Text('Sign Up', style: TextStyle(fontSize: 25),),
                      style: ElevatedButton.styleFrom(primary: Color(0xFFCAB8E0).withOpacity(0.33), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SSregister()));
                      }),
                ],
              ),
            ),
            ],
          ),
      ),
        ),
      ),
    )
    );
  }
}
