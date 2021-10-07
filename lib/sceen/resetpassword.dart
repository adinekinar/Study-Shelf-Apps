import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
              child: Column(
                children: [
                  Container(child: Text("Email :", style: TextStyle(fontSize: 18)), margin: EdgeInsets.only(right: 200, top: 5, bottom: 10),),
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
                  ElevatedButton(
                      child: Text('Reset Password', style: TextStyle(fontSize: 25),),
                      style: ElevatedButton.styleFrom(primary: Color(0xFFEFD1A9).withOpacity(0.33), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                      onPressed: () async {
                        FirebaseAuth.instance.sendPasswordResetEmail(email: emailcont.text);
                        Text('Please check the incoming message in your email.', style: TextStyle(fontSize: 14),);
                        Text('Study Shelf have sent you an email to reset your password.', style: TextStyle(fontSize: 14),);
                      }),
                  Container(
                    child: MaterialButton(child: Text('Back to Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PassReset()));
                      }),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
}
}
