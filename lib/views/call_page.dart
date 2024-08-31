import 'package:flutter/cupertino.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1484647939, // Your ZEGO app ID
      appSign: '751874393a5ce84d7660387e93aabdd5f9be8e1faeaacd1ed95d9e199f6ec402', // Your ZEGO app sign
      userID: 'Fake Call', // User ID for the fake call
      userName: 'User', // User name for the fake call
      callID: callID, // Unique call ID
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
