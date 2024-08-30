import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LiveTrackingScreen extends StatefulWidget {
  @override
  _LiveTrackingScreenState createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  bool isLiveTrackingEnabled = false;
  bool isGeolocationEnabled = false;
  String currentLocation = 'Unknown';
  Position? position;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = 'Lat: ${position?.latitude}, Long: ${position?.longitude}';
    });
  }

  void _toggleTrackingMode(bool isLiveTracking) {
    setState(() {
      isLiveTrackingEnabled = isLiveTracking;
      isGeolocationEnabled = !isLiveTracking;
    });

    if (isGeolocationEnabled) {
      _getCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.redAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Live Tracking',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Select tracking mode',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: isLiveTrackingEnabled,
                            onChanged: (value) {
                              _toggleTrackingMode(true);
                            },
                            activeColor: Colors.redAccent,
                          ),
                          Text('Live Camera', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<bool>(
                            value: false,
                            groupValue: isLiveTrackingEnabled,
                            onChanged: (value) {
                              _toggleTrackingMode(false);
                            },
                            activeColor: Colors.redAccent,
                          ),
                          Text('Geolocation', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (isLiveTrackingEnabled) ...[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Handle action when camera feed is tapped
                    },
                    child: buildLiveCameraFeed(),
                  ),
                ),
              ] else if (isGeolocationEnabled) ...[
                Expanded(
                  child: buildGeolocationWidget(),
                ),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: Text('SOS', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {
            // Handle SOS button press
          },
        ),
      ),
    );
  }

  Widget buildLiveCameraFeed() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage('assets/images/traffic_camera_feed.png'), // Placeholder image
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            offset: Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Row(
              children: [
                Icon(Icons.camera, color: Colors.white),
                SizedBox(width: 5),
                Text('Cam 01', style: TextStyle(color: Colors.white)),
                SizedBox(width: 20),
                Icon(Icons.location_on, color: Colors.white),
                SizedBox(width: 5),
                Text('Kollamring', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.5),
                    offset: Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Text(
                'Live',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle fullscreen toggle
                  },
                  icon: Icon(Icons.fullscreen, color: Colors.white),
                  label: Text('Fullscreen'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.white.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle change camera
                  },
                  icon: Icon(Icons.switch_camera, color: Colors.white),
                  label: Text('Switch Camera'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.white.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGeolocationWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on, color: Colors.redAccent, size: 100),
          SizedBox(height: 20),
          Text(
            'Current Location:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            currentLocation,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
