import 'dart:math'; // Import dart:math for sqrt
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler

class SpyCamDetector extends StatefulWidget {
  @override
  _SpyCamDetectorState createState() => _SpyCamDetectorState();
}

class _SpyCamDetectorState extends State<SpyCamDetector> {
  double _magneticField = 0;
  String _detectionMessage = "No Spy Camera Detected";
  Color _iconColor = Colors.green;
  IconData _iconData = Icons.check_circle;

  CameraController? _cameraController;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();

    // Listen to the magnetic field sensor
    magnetometerEvents.listen((MagnetometerEvent event) {
      // Calculate the magnitude of the magnetic field
      double magnitude = _calculateMagnitude(event.x, event.y, event.z);

      setState(() {
        _magneticField = magnitude;

        // Update the threshold to 50 µT for detection
        if (_magneticField > 100) { // Adjusted threshold for a stronger alert
          _detectionMessage = "Strong Magnetic Field Detected! Possible Spy Camera!";
          _iconColor = Colors.red;
          _iconData = Icons.dangerous;
        } else if (_magneticField > 50) { // Adjusted threshold to 50 µT for initial detection
          _detectionMessage = "Magnetic Field Detected! Stay Alert!";
          _iconColor = Colors.orange;
          _iconData = Icons.warning;
        } else {
          _detectionMessage = "No Spy Camera Detected";
          _iconColor = Colors.green;
          _iconData = Icons.check_circle;
        }
      });
    });
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted) {
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      await _initializeCamera();
    } else {
      setState(() {
        _detectionMessage = "Camera permission is required to use this feature.";
        _iconColor = Colors.red;
        _iconData = Icons.error;
      });
    }
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        throw CameraException('NoCameraAvailable', 'No camera is available.');
      }

      final camera = cameras.first;

      _cameraController = CameraController(
        camera,
        ResolutionPreset.medium,
      );

      await _cameraController!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
      setState(() {
        _detectionMessage = "Error initializing camera: $e";
        _iconColor = Colors.red;
        _iconData = Icons.error;
      });
    }
  }

  double _calculateMagnitude(double x, double y, double z) {
    return sqrt(x * x + y * y + z * z); // Use sqrt from dart:math
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spy Cam Detector'),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          _isCameraInitialized
              ? CameraPreview(_cameraController!)
              : Center(
            child: Text(
              'Camera is not active',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purpleAccent.withOpacity(0.5),
                  Colors.blueAccent.withOpacity(0.5)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _iconData,
                    color: _iconColor,
                    size: 100,
                  ),
                  SizedBox(height: 20),
                  Text(
                    _detectionMessage,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Magnetic Field: ${_magneticField.toStringAsFixed(2)} µT",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
