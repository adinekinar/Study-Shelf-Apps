import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_shelf/sceen/homepage.dart';
import 'package:study_shelf/sceen/registerpage.dart';
import 'package:study_shelf/sceen/resetpassword.dart';

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
            alignment: Alignment.center,
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
               height: MediaQuery.of(context).size.height/1.75,
               decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      child: Text("LOGIN", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),textAlign: TextAlign.center,),
                      margin: EdgeInsets.only(top: 20),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(child: Text("Email :", style: TextStyle(fontSize: 16)), ),
                  SizedBox(height: 10,),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      width: 254, height: 52,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                              controller: emailcnt,
                              decoration: InputDecoration(hintText: 'Input Email..', icon: Icon(Icons.email, size: 24), border: InputBorder.none),
                            ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(child: Text("Password :", style: TextStyle(fontSize: 16),textAlign: TextAlign.left,)),
                  SizedBox(height: 10,),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      width: 254, height: 52,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        controller: passcnt,
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'Input Password..', icon: Icon(Icons.vpn_key, size: 24), border: InputBorder.none),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.zero,
                      child: MaterialButton(child: Text('Forgot password?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PassReset()));
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                        child: Text('Login', style: TextStyle(fontSize: 20),),
                        style: ElevatedButton.styleFrom(primary: Color(0xFFEFD1A9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                        onPressed: () async {
                          content : await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcnt.text, password: passcnt.text);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                          setState(() {});
                        }),
                  ),
                  Center(child: Container(child: Text('Haven’t account?', style: TextStyle(fontSize: 16),), margin: EdgeInsets.only(top: 10, bottom: 10),)),
                  Center(
                    child: ElevatedButton(
                        child: Text('Sign Up', style: TextStyle(fontSize: 20),),
                        style: ElevatedButton.styleFrom(primary: Color(0xFFA386C8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SSregister()));
                        }),
                  ),
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
