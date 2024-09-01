import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'BusStationCard.dart';
import 'HospitalCard.dart';
import 'PharmacyCard.dart';
import 'PoliceStationCard.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Position? _currentPosition;
  bool _isLoading = false;

  List<dynamic> _hospitalResults = [];
  List<dynamic> _policeResults = [];
  List<dynamic> _pharmacyResults = [];
  List<dynamic> _busStationResults = [];

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    setState(() {
      _isLoading = true;
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

      // Fetch places after obtaining the location
      await _fetchAllNearbyPlaces();
    } catch (e) {
      print("Error fetching location: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchAllNearbyPlaces() async {
    if (_currentPosition != null) {
      final latitude = _currentPosition!.latitude;
      final longitude = _currentPosition!.longitude;

      _hospitalResults = await _fetchPlacesForType(latitude, longitude, 'hospital');
      _policeResults = await _fetchPlacesForType(latitude, longitude, 'police');
      _pharmacyResults = await _fetchPlacesForType(latitude, longitude, 'pharmacy');
      _busStationResults = await _fetchPlacesForType(latitude, longitude, 'bus_station');

      setState(() {});
    }
  }

  Future<List<dynamic>> _fetchPlacesForType(double latitude, double longitude, String type) async {
    final apiKey = 'YOUR_GOOGLE_API_KEY';
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&type=$type&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['results'];
      } else {
        print('Failed to load nearby $type');
        return [];
      }
    } catch (e) {
      print('Failed to fetch places for $type: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nearby Services',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.black,
        child: _isLoading
            ? Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
        )
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              _buildServiceRow(
                PoliceStationCard(
                  key: UniqueKey(),
                  openMapFunc: () => _openMapWithQuery('police', _policeResults),
                ),
                PharmacyCard(
                  key: UniqueKey(),
                  openMapFunc: () => _openMapWithQuery('pharmacy', _pharmacyResults),
                ),
              ),
              SizedBox(height: 20),
              _buildServiceRow(
                HospitalCard(
                  key: UniqueKey(),
                  openMapFunc: () => _openMapWithQuery('hospital', _hospitalResults),
                ),
                BusStationCard(
                  key: UniqueKey(),
                  openMapFunc: () => _openMapWithQuery('bus_station', _busStationResults),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceRow(Widget firstCard, Widget secondCard) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildCard(firstCard),
        ),
        SizedBox(width: 20),
        Expanded(
          child: _buildCard(secondCard),
        ),
      ],
    );
  }

  Widget _buildCard(Widget child) {
    return GestureDetector(
      onTap: () {}, // Add functionality for tapping the card
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }

  Future<void> _openMapWithQuery(String query, List<dynamic> results) async {
    if (results.isEmpty) {
      print("No results found for $query.");
      return;
    }

    // Handle the results here
    // You can navigate to a new screen to display these results or show on a map.
    print("Results for $query: $results");
  }
}