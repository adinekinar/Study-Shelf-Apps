import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_shelf/sceen/homepage.dart';
import 'package:study_shelf/sceen/loginpage.dart';
import 'package:study_shelf/sceen/process_uname.dart';

class SSregister extends StatefulWidget {
  const SSregister({Key? key}) : super(key: key);

  @override
  _SSregisterState createState() => _SSregisterState();
}

class _SSregisterState extends State<SSregister> {
  final emailcnt = TextEditingController();
  final passcnt = TextEditingController();
  final usercnt = TextEditingController();
  final int point = 10;

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
                    height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                    children: [
                      Container(
                        child: Text("SIGN UP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),textAlign: TextAlign.center,),
                        margin: EdgeInsets.only(top: 20),
                      ),
                      Container(child: Text("Email :", style: TextStyle(fontSize: 18)), margin: EdgeInsets.only(right: 200, top: 5, bottom: 10),),
                    Container(
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
                      Container(child: Text("Username :", style: TextStyle(fontSize: 18),textAlign: TextAlign.left,),margin: EdgeInsets.only(top: 10, right: 165, bottom: 10),),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      width: 254, height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        controller: usercnt,
                        decoration: InputDecoration(hintText: 'Input Username..', icon: Icon(CupertinoIcons.pencil, size: 24), border: InputBorder.none),
                    ),
                  ),
                      Container(child: Text("Password :", style: TextStyle(fontSize: 18),textAlign: TextAlign.left,),margin: EdgeInsets.only(top: 10, right: 165, bottom: 10),),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
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
                    ElevatedButton(
                      child: Text('Sign Up', style: TextStyle(fontSize: 25),),
                      style: ElevatedButton.styleFrom(primary: Color(0xFFEFD1A9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                      onPressed: () async {
                        content: await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailcnt.text, password: passcnt.text);
                        content: User? userupdate = FirebaseAuth.instance.currentUser;
                        content: userupdate!.updateProfile(displayName: usercnt.text);
                        content: unameStore(usercnt.text, point);
                        popUp(context);
                        setState(() {});
                      }),
                      Container(child: Text('Have an account?', style: TextStyle(fontSize: 18),), margin: EdgeInsets.only(top: 10, bottom: 10),),
                      ElevatedButton(
                          child: Text('Login', style: TextStyle(fontSize: 25),),
                          style: ElevatedButton.styleFrom(primary: Color(0xFFA386C8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SSlogin()));
                          } ),
                    ],
                  ),),
                ],
              ),
            ),
        ),
        ),
      ),
    );
  }
  void popUp(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
          child: Container(
          height: 368,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(60)
          ),
          child:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network('https://i.postimg.cc/Hk1vdwD2/You-Got-10-points.png', height: 300, width: 300,),
              Container(margin : EdgeInsets.only(bottom: 20), child: RaisedButton(color: const Color(0xFFCAB8E0),child: Text('Next to Homepage'), onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));}))
            ],
          ),
        ),
      );
    }
  );
}
