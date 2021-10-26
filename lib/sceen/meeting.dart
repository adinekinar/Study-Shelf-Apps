import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:study_shelf/sceen/homepage.dart';


class Meeting extends StatefulWidget {
  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  final serverText = TextEditingController();
  bool? isAudioOnly = true;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;

  String? valueDropmenu;
  List listpoint = ['StudyShelfRoom1','StudyShelfRoom2','StudyShelfRoom3'];

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF1EEEE),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Study Shelf', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          backgroundColor: const Color(0xFFC4B1DC),
          leading: IconButton(
              icon: Icon(CupertinoIcons.back, size: 35, color: Colors.black),
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));}),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: kIsWeb
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.30,
                child: meetConfig(),
              ),
              Container(
                  width: width * 0.60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        color: Colors.white54,
                        child: SizedBox(
                          width: width * 0.60 * 0.70,
                          height: width * 0.60 * 0.70,
                          child: JitsiMeetConferencing(
                            extraJS: [
                              // extraJs setup example
                              '<script>function echo(){console.log("echo!!!")};</script>',
                              '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
                            ],
                          ),
                        )),
                  ))
            ],
          )
              : meetConfig(),
        ),
      ),
    );
  }

  Widget meetConfig() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(padding:EdgeInsets.symmetric(horizontal: 40),child: Text('Choose Study Room : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
          /*SizedBox(
            height: 16.0,
          ),
          TextField(
            controller: serverText,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Server URL",
                hintText: "Hint: Leave empty for meet.jitsi.si"),
          ),*/
          Container(
            height: 60,
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.white30,
              border: Border.all(color: Color(0xFFAEAEAE)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: DropdownButton(
                      hint: Text('Choose room..    '),
                      icon: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/4),child: Icon(Icons.arrow_drop_down_rounded)),
                      value: valueDropmenu,
                      onChanged: (newValue) {
                        setState(() {
                          valueDropmenu = newValue as String?;
                        });
                      },
                      underline: SizedBox(),
                      items: (listpoint).map((valueItem) {
                        return DropdownMenuItem(value: valueItem, child: Text(valueItem),);
                      }).toList(),
                    ),
            ),
            ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(20)
            ),
            child: CheckboxListTile(
              activeColor: const Color(0xFFC4B1DC),
              title: Row(
                children: [
                  Icon(Icons.videocam_off_rounded, size: 25,),
                  SizedBox(width: 12,),
                  Text("Off Camera", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ],
              ),
              value: isVideoMuted,
              onChanged: _onVideoMutedChanged,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: SizedBox(
              height: 45.0,
              child: ElevatedButton(
                onPressed: () {
                  _joinMeeting();
                },
                child: Text(
                  'Join Stream',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                style: ElevatedButton.styleFrom(primary: Color(0xFFA386C8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
              ),
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
        ],
      ),
    );
  }

  _onAudioOnlyChanged() {
    setState(() {
      isAudioOnly = true;
    });
  }

  _onAudioMutedChanged() {
    setState(() {
      isAudioMuted = true;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
      FeatureFlagEnum.CALENDAR_ENABLED: false,
      FeatureFlagEnum.CALL_INTEGRATION_ENABLED: false,
      FeatureFlagEnum.CHAT_ENABLED: false,
      FeatureFlagEnum.INVITE_ENABLED: false,
      FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
      FeatureFlagEnum.MEETING_NAME_ENABLED: true,
      FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
      FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE: false,
      FeatureFlagEnum.PIP_ENABLED: true,
      FeatureFlagEnum.RAISE_HAND_ENABLED: true,
    };
    if (!kIsWeb) {
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }
    // Define meetings options here
    var options = JitsiMeetingOptions(room: valueDropmenu!)
      ..serverURL = serverUrl
      ..subject = valueDropmenu!
      ..userDisplayName = FirebaseAuth.instance.currentUser!.displayName
      ..userEmail = FirebaseAuth.instance.currentUser!.email
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": valueDropmenu!,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": FirebaseAuth.instance.currentUser!.displayName}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}