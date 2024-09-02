import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ShakeDemo extends StatefulWidget {
  @override
  _ShakeDemoState createState() => _ShakeDemoState();
}

class _ShakeDemoState extends State<ShakeDemo> with SingleTickerProviderStateMixin {
  ShakeDetector? detector;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    // Start shake detection
    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        _handleShake();
      },
    );
  }

  void _handleShake() async {
    print("Phone is shaken!");

    // Play animation on shake
    _animationController?.forward(from: 0.0);

    // Check if the device can vibrate
    bool? canVibrate = await Vibration.hasVibrator();
    if (canVibrate == true) {
      // Trigger a vibration
      Vibration.vibrate(duration: 500);  // Vibrate for 500 milliseconds
    } else {
      print("Device does not support vibration.");
    }

    // Make a direct phone call
    _makeDirectPhoneCall('122333333322');
  }

  Future<void> _makeDirectPhoneCall(String number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    if (res == null || !res) {
      print('Could not make the call.');
    }
  }

  @override
  void dispose() {
    detector?.stopListening();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('Shake Detection Demo'),
        backgroundColor: Colors.blueGrey[700],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController!,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_animationController!.value * 0.3),
                  child: child,
                );
              },
              child: Icon(
                Icons.vibration,
                color: Colors.tealAccent,
                size: 100.0,
              ),
            ),
            SizedBox(height: 50.0),
            Text(
              'Shake your phone to trigger an action!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}