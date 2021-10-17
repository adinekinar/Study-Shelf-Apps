import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'eachpostpages.dart';

class postReplay extends StatelessWidget {
  final String doc_id;
  const postReplay({Key? key, required this.doc_id}) : super(key: key);

  Future<void> _launchInBrowser(String url, {bool forceWebView = false, bool enableJavaScript = false}) async {
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    final comment = TextEditingController();
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('FormPost').doc(doc_id).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
            backgroundColor: const Color(0xFFF1EEEE),
            appBar: AppBar(
              title: Text(snapshot.data!['Title'], style: TextStyle(color: Colors.black),),
              centerTitle: true,
              backgroundColor: const Color(0xFFCAB8E0),
              actions: [
                IconButton(icon: Icon(Icons.download_rounded, color: const Color(0xFF585858),),
                    onPressed: () async {
                      _launchInBrowser(snapshot.data!['url']);
                    }
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                  child: Stack(
                    children: <Widget>[
                      Column(
                          children: [
                            MaterialButton(
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 30, bottom: 20),
                                  height: 202, width: 267,
                                  decoration: BoxDecoration(
                                    color: Color((snapshot.data!['File format'] == 'pdf') ? (0xFFCAB8E0) : (0xFFFFFFFF)),
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage((snapshot.data!['File format'] == 'pdf') ?  'https://i.postimg.cc/VNTd9w2Q/PDF-File-Online-1-removebg-preview.png' : snapshot.data!['url']),
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                final file = await FileApi.loadFile(snapshot.data!['url']);
                                (snapshot.data!['File format'] == 'pdf') ? openPdf(context, file) : {};
                              },
                            ),
                            Container(child: Text(snapshot.data!['Title']+' :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                            Container(child: Text(snapshot.data!['Subject'], style: TextStyle(fontSize: 20))),
                            Container(child: Text('tag : #'+snapshot.data!['Sub-subject Tag'])),
                            ElevatedButton(
                                child: Text(snapshot.data!['Caption file'], style: TextStyle(
                                    fontSize: 16, color: const Color(0xFF585858)),),
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFCAB8E0).withOpacity(0.33),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0)),
                                    minimumSize: (Size(50, 30))),
                                onPressed: () {}),
                            Text('Created by : '+snapshot.data!['Username']),
                            Container(height: 357.5),
                          ]
                      ),
                      Positioned.fill(
                        child: DraggableScrollableSheet(
                            initialChildSize: 0.47,
                            maxChildSize: 0.55,
                            minChildSize: 0.47,
                            builder: (_, ScrollController){
                              return Container(
                                decoration: BoxDecoration(color: Color(0xFFF7F5F5), borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                                ),
                                child: Column(
                                  children: [
                                    Container(margin: EdgeInsets.only(top: 20, bottom: 7), child: Text('Comments', style: TextStyle(color: const Color(0xFF585858), fontSize: 20, fontWeight: FontWeight.bold),)),
                                    Container(margin: EdgeInsets.only(bottom: 10), height: 7, width: 125, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xFFCAB8E0)),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(right: 5),
                                            width: 300, height: 50,
                                            padding: EdgeInsets.only(left: 20),
                                            decoration: BoxDecoration(color: Colors.white30, border: Border.all(color: const Color(0xFFAEAEAE).withOpacity(0.2)), borderRadius: BorderRadius.circular(20)),
                                            child: TextField(controller: comment, decoration: InputDecoration(border: InputBorder.none, hintText: "Type your comment.."),)
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.send_rounded, size: 30, color: const Color(0xFF585858),),
                                          onPressed: (){
                                            commentS('FormPost', snapshot.data!.id, comment.text);
                                          },
                                        ),
                                      ],
                                    ),
                                    StreamBuilder(
                                        stream: FirebaseFirestore.instance.collection('FormPost').doc(snapshot.data!.id).collection('Comments').snapshots(),
                                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if(!snapshot.hasData){
                                            return Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                          return Expanded(
                                            child: ListView.builder(
                                              itemCount: snapshot.data!.docs.length,
                                              controller: ScrollController,
                                              itemBuilder: (context, index) {
                                                DocumentSnapshot docsnapshotes = snapshot.data!.docs[index];
                                                return Container(
                                                  padding: EdgeInsets.all(20),
                                                  margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFFE9E3EB),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child : Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(docsnapshotes['Username']+' :', style: TextStyle(color: Color(0xFF585858),)),
                                                      Text(docsnapshotes['Context comment']),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                      ),
                    ],
                  )
              ),
            ),
          );}
        );
      }
  }
