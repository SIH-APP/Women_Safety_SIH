import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;
  Position? _currentPosition;
  final Set<Marker> _markers = {};
  bool _isLoading = true; // Indicator to show loading state

  final LatLng _initialCenter = const LatLng(37.77483, -122.41942); // San Francisco coordinates

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (_currentPosition != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          14.0,
        ),
      );
    }
  }

  Future<void> _fetchCurrentLocation() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        // Add marker for current location
        _markers.add(
          Marker(
            markerId: MarkerId('current_location'),
            position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            infoWindow: InfoWindow(title: 'Your Location'),
          ),
        );
      });

      await _fetchNearbyPlaces();
    } catch (e) {
      print("Error fetching location: $e");
      // Show an error message or handle it gracefully
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  Future<void> _fetchNearbyPlaces() async {
    if (_currentPosition != null) {
      final latitude = _currentPosition!.latitude;
      final longitude = _currentPosition!.longitude;
      final apiKey = 'AIzaSyA6UUZunEH12V49__hjo-yfdc8YAC-_oKg';

      await _fetchPlacesForType(latitude, longitude, 'hospital');
      await _fetchPlacesForType(latitude, longitude, 'police');
      await _fetchPlacesForType(latitude, longitude, 'transit_station');
    }
  }

  Future<void> _fetchPlacesForType(double latitude, double longitude, String type) async {
    final apiKey = 'AIzaSyA6UUZunEH12V49__hjo-yfdc8YAC-_oKg';
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&type=$type&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'];

        setState(() {
          for (var result in results) {
            final placeLat = result['geometry']['location']['lat'];
            final placeLng = result['geometry']['location']['lng'];
            final placeName = result['name'];

            _markers.add(
              Marker(
                markerId: MarkerId(placeName),
                position: LatLng(placeLat, placeLng),
                infoWindow: InfoWindow(title: placeName),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  _getMarkerHue(type),
                ),
              ),
            );
          }
        });
      } else {
        print('Failed to load nearby $type');
      }
    } catch (e) {
      print('Failed to fetch places for type $type: $e');
    }
  }

  double _getMarkerHue(String type) {
    switch (type) {
      case 'hospital':
        return BitmapDescriptor.hueRed;
      case 'police':
        return BitmapDescriptor.hueBlue;
      case 'transit_station':
        return BitmapDescriptor.hueGreen;
      default:
        return BitmapDescriptor.hueAzure;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps - Nearby Services'),
        backgroundColor: Colors.black,
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialCenter,
          zoom: 11.0,
        ),
        markers: _markers,
      ),
    );
  }
}
