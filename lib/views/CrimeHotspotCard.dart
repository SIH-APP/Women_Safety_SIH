import 'package:flutter/material.dart';

class CrimeHotspotCard extends StatelessWidget {
  final VoidCallback openMapFunc;

  CrimeHotspotCard({required Key key, required this.openMapFunc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: openMapFunc,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            'Show Crime Hotspots',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}