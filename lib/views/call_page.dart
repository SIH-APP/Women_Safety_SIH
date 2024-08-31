import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:audioplayers/audioplayers.dart';

class CallPage extends StatefulWidget {
  final String callID;

  const CallPage({Key? key, required this.callID}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playRingtone();  // Automatically play the ringtone when the page is initialized
    _startFakeCall(); // Start the fake call after the ringtone has played
  }

  Future<void> _playRingtone() async {
    // Play a short ringtone sound
    await _audioPlayer.play(AssetSource('assets/audio/mi_remix.mp3'));
  }

  Future<void> _startFakeCall() async {
    // Wait for a few seconds while the ringtone plays
    await Future.delayed(Duration(seconds: 3));

    // Stop the ringtone before starting the call
    await _audioPlayer.stop();

    // Now show the fake call screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ZegoUIKitPrebuiltCall(
          appID: 1484647939, // Your ZEGO app ID
          appSign: '751874393a5ce84d7660387e93aabdd5f9be8e1faeaacd1ed95d9e199f6ec402', // Your ZEGO app sign
          userID: 'Fake Call', // User ID for the fake call
          userName: 'User', // User name for the fake call
          callID: widget.callID, // Unique call ID
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Show a loading indicator while the ringtone plays
      ),
    );
  }
}
