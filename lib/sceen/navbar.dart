import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_shelf/sceen/loginpage.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
          child : ListView(
                padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                    decoration: BoxDecoration(
                      color: const Color(0xFFCAB8E0)
                    ),
                    child: Stack(
                      children : [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            child: Icon(Icons.person,color: const Color(0xFF585858), size: 60),
                            backgroundColor: const Color(0xFFF1EEEE),
                            radius: 40,),
                        ),
                        Align(
                          alignment: Alignment.topRight + Alignment(0, .2),
                          child: Text(FirebaseAuth.instance.currentUser!.displayName.toString(), style: TextStyle(color: const Color(0xFF585858), fontSize: 20),),
                        ),
                        Align(
                          alignment: Alignment.topRight + Alignment(0, .6),
                          child: Text(FirebaseAuth.instance.currentUser!.email.toString(), style: TextStyle(color: const Color(0xFF585858), fontSize: 16),),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 220),
                            alignment: Alignment.centerRight+ Alignment(0, .6),
                            child: Row(
                              children: [
                                Image.network('https://i.postimg.cc/CMsRMRhk/badge.png', width: 20,height: 20,),
                                Text('10', style: TextStyle(color: const Color(0xFF585858), fontSize: 20),),
                              ],
                            ),
                        ),
                    ]),
                    ),
                  ListTile(
                    title: Text('Log Out'),
                    leading: Icon(Icons.logout_rounded, color: const Color(0xFF585858),),
                    onTap: () async {
                      content : await FirebaseAuth.instance.signOut();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SSlogin()));
                    },
                  ),
                ],
              )
          );
  }
}
