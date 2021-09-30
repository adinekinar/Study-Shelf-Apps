import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_shelf/sceen/homepagereq.dart';
import 'package:study_shelf/sceen/selectpage.dart';
import 'package:study_shelf/sceen/process_uname.dart';

class Formq extends StatefulWidget {
  const Formq({Key? key}) : super(key: key);

  @override
  _FormqState createState() => _FormqState();
}

class _FormqState extends State<Formq> {
  final title = TextEditingController();
  final captf = TextEditingController();
  final subop = TextEditingController();
  final ssubtag = TextEditingController();

  String? valueDropmenu;
  int? value;
  List listpoint = ['5','10','15','20','25'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF1EEEE),
        appBar: AppBar(
          backgroundColor: const Color(0xFFC4B1DC),
          centerTitle: true,
          title: Text("Study Shelf", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Selectpg())),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 55, top: 20),
                child: Row(
                  children: [
                    Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(right: 15),
                      child: Icon(Icons.paste_rounded, size: 26, color: const Color(0xFF585858), ),
                    ),
                    Text("Post your new notes request..", style: TextStyle(fontSize: 18),),
                  ],
                ),
              ),
              Inpform(ttl: 'Title request :', r: 250, h: 33, cont: title,),
              Inpform(ttl: 'Caption request :', r: 230, h: 58, cont: captf,),
              Inpform(ttl: 'Subject option :', r: 240, h: 33, cont: subop,),
              Inpform(ttl: 'Sub-subject tag :', r: 235, h: 120, cont: ssubtag,),
              Container(child: Text("Total Reward to Give :"), margin: EdgeInsets.only(top: 10, right: 200),),
              Container(
                margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        border: Border.all(color: Color(0xFFAEAEAE)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButton(
                        hint: Text('Choose point..    '),
                        icon: Icon(Icons.arrow_drop_down_rounded),
                        value: valueDropmenu,
                        onChanged: (newValue) {
                          setState(() {
                            valueDropmenu = newValue as String?;
                          });
                        },
                        underline: SizedBox(),
                        items: listpoint.map((valueItem) {
                          return DropdownMenuItem(value: valueItem, child: Text('$valueItem points'),);
                      }).toList(),
                      ),
                    ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  child: Text('Request', style: TextStyle(fontSize: 25, color: Colors.black),),
                  style: ElevatedButton.styleFrom(primary: Color(0xFFEFD1A9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
                  onPressed: () async {
                    value = int.parse(valueDropmenu!);
                    content: DatabaseReq().fillReq(title.text, captf.text, subop.text, ssubtag.text, value!);
                    Navigator.push(this.context, MaterialPageRoute(builder: (context) => Homreq()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Inpform extends StatelessWidget {
  final String ttl;
  final double r;
  final double h;
  final TextEditingController cont;
  const Inpform({
    Key? key, required this.ttl,
    required this.r, required this.h,
    required this.cont,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text(ttl, style: TextStyle(fontSize: 14),),
            margin: EdgeInsets.only(top: 10, bottom: 4, right: r,),
          ),
          Container(
            width: 335, height: h,
            padding: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(color: Colors.white30, border: Border.all(color: const Color(0xFFAEAEAE)), borderRadius: BorderRadius.circular(20)),
            child: TextField(
              controller: cont,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}


