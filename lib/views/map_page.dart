import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(28.474387, 77.50399), // Default to a location in Greater Noida
    zoom: 14,
  );

  List<Marker> _allMarkers = [];
  List<Marker> _visibleMarkers = [];

  @override
  void initState() {
    super.initState();
    _loadAllMarkers(); // Load all markers initially
  }

  void _loadAllMarkers() {
    _allMarkers = [
      Marker(
        markerId: MarkerId('Pari Chowk'),
        position: LatLng(28.474387, 77.50399),
        infoWindow: InfoWindow(title: 'Pari Chowk', snippet: 'High Risk: Eve Teasing'),
      ),
      Marker(
        markerId: MarkerId('Alpha Commercial Belt'),
        position: LatLng(28.471995, 77.497316),
        infoWindow: InfoWindow(title: 'Alpha Commercial Belt', snippet: 'Medium Risk: Robbery'),
      ),
      Marker(
        markerId: MarkerId('Knowledge Park III'),
        position: LatLng(28.46979, 77.503097),
        infoWindow: InfoWindow(title: 'Knowledge Park III', snippet: 'High Risk: Assault'),
      ),
      // Add other hotspots similarly...
    ];
  }

  void _updateVisibleMarkers(CameraPosition position) {
    // Assuming zoom level is at least 10 to show markers
    if (position.zoom > 10) {
      setState(() {
        _visibleMarkers = _allMarkers.where((marker) {
          return _isMarkerVisible(marker.position, position);
        }).toList();
      });
    }
  }

  bool _isMarkerVisible(LatLng markerPosition, CameraPosition currentCameraPosition) {
    // Implement logic to determine if a marker is within the visible region
    double latDiff = (markerPosition.latitude - currentCameraPosition.target.latitude).abs();
    double lngDiff = (markerPosition.longitude - currentCameraPosition.target.longitude).abs();

    return latDiff < 0.05 && lngDiff < 0.05; // Adjust the threshold as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crime Hotspots'),
        backgroundColor: Colors.deepPurple,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kInitialPosition,
        markers: Set<Marker>.of(_visibleMarkers),
        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) {
            _controller.complete(controller);
          }
        },
        onCameraMove: (CameraPosition position) {
          _updateVisibleMarkers(position);
        },
      ),
    );
  }
}