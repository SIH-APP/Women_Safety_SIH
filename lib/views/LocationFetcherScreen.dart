import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationFetcherScreen extends StatefulWidget {
  @override
  _LocationFetcherScreenState createState() => _LocationFetcherScreenState();
}

class _LocationFetcherScreenState extends State<LocationFetcherScreen> {
  Position? _currentPosition;
  List<dynamic> _hospitals = [];
  List<dynamic> _policeStations = [];
  List<dynamic> _transportations = [];

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
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

    _fetchNearbyPlaces();
  }

  Future<void> _fetchNearbyPlaces() async {
    if (_currentPosition != null) {
      final latitude = _currentPosition!.latitude;
      final longitude = _currentPosition!.longitude;
      final apiKey = 'YOUR_GOOGLE_PLACES_API_KEY';

      await _fetchPlacesForType(latitude, longitude, 'hospital', _hospitals);
      await _fetchPlacesForType(latitude, longitude, 'police', _policeStations);
      await _fetchPlacesForType(latitude, longitude, 'transit_station', _transportations);
    }
  }

  Future<void> _fetchPlacesForType(double latitude, double longitude, String type, List<dynamic> storage) async {
    final apiKey = 'YOUR_GOOGLE_PLACES_API_KEY';
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&type=$type&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        storage.addAll(data['results']);
      });
    } else {
      throw Exception('Failed to load nearby $type');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Nearby Services'),
        backgroundColor: Colors.black,
      ),
      body: _currentPosition == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMapPreview(context, 'Your Current Location'),
                _buildShareLocationButton(context),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildLocationCard(
                    context,
                    title: 'Nearest Hospital',
                    locations: _hospitals,
                    icon: Icons.local_hospital,
                  ),
                  SizedBox(height: 20),
                  _buildLocationCard(
                    context,
                    title: 'Nearest Police Station',
                    locations: _policeStations,
                    icon: Icons.local_police,
                  ),
                  SizedBox(height: 20),
                  _buildLocationCard(
                    context,
                    title: 'Nearest Transportation',
                    locations: _transportations,
                    icon: Icons.directions_transit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapPreview(BuildContext context, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 160,
          height: 100,
          color: Colors.white, // Placeholder for the map image
          child: Center(child: Text('Map Preview')),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildShareLocationButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle share location
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.share, color: Colors.white),
            SizedBox(width: 8),
            Text('Share my Location', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard(BuildContext context, {required String title, required List<dynamic> locations, required IconData icon}) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.redAccent, size: 30),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: locations.isEmpty
            ? Text('No locations found', style: TextStyle(color: Colors.white54))
            : _buildLocationTile(locations.first),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {
          // Navigate to the full list of locations or details
        },
      ),
    );
  }

  Widget _buildLocationTile(dynamic location) {
    final placeName = location['name'];
    final address = location['vicinity'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          placeName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          address,
          style: TextStyle(color: Colors.white54),
        ),
      ],
    );
  }
}
