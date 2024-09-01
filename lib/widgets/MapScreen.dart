import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final List<dynamic> hotspots;

  MapScreen({required this.hotspots});

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = hotspots.map((hotspot) {
      return Marker(
        markerId: MarkerId(hotspot['Location Name']),
        position: LatLng(hotspot['Latitude'], hotspot['Longitude']),
        infoWindow: InfoWindow(
          title: hotspot['Location Name'],
          snippet: '${hotspot['Crime Type']} - ${hotspot['Risk Level']} Risk',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          hotspot['Risk Level'] == 'High' ? BitmapDescriptor.hueRed : BitmapDescriptor.hueOrange,
        ),
      );
    }).toSet();

    return Scaffold(
      appBar: AppBar(
        title: Text('Crime Hotspots'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(hotspots[0]['Latitude'], hotspots[0]['Longitude']),
          zoom: 12,
        ),
        markers: markers,
      ),
    );
  }
}