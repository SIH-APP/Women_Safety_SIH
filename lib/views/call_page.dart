import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:audioplayers/audioplayers.dart';

class CallPage extends StatefulWidget {
  final String callID;

  const CallPage({super.key, required this.callID});

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final AudioPlayer _audioPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  @override
  void initState() {
    super.initState();
    _startProcess(); // Start the ringtone and then the fake call
  }

  Future<void> _startProcess() async {
    try {
      // Attempt to play the ringtone sound from assets
      print('Attempting to play ringtone...');
      int result = await _audioPlayer.play(AssetSource('audio/audio.mp3')); // Corrected asset path

      // Check if the ringtone started successfully
      if (result == 1) {
        print('Ringtone started successfully.');
      } else {
        print('Failed to start ringtone.');
      }

      // Wait for 2 seconds while the ringtone plays
      await Future.delayed(Duration(seconds: 2));

      // Stop the ringtone before starting the call
      await _audioPlayer.stop();
      print('Ringtone stopped.');

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
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose of the audio player when the widget is removed
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