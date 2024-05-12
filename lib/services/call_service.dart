import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CallPage extends StatelessWidget {
   CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;
 late FirebaseAuth _auth;
   
  @override
  
  Widget build(BuildContext context) {
    _auth = FirebaseAuth.instance;
        String? currentUserUid = _auth.currentUser?.uid;

    return ZegoUIKitPrebuiltCall(
      appID: 2102692006, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: "5bb5f3f276b1c6fed7f3a663f7995a490f3f7e8c4114aa8a20a21b1b24801a3b", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: currentUserUid!,
      userName: "Anonymus User",
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
