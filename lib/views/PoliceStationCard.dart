import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PoliceStationCard extends StatelessWidget {
  final Function openMapFunc;

  const PoliceStationCard({required Key key, required this.openMapFunc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () {
                _launchMapsForPoliceStations();
              },
              child: Container(
                height: 100,
                width: 100,
                child: Center(
                  child: Image.asset(
                    "assets/images/policestation.png",
                    height: 50,
                  ),
                ),
              ),
            ),
          ),
          Text("Police Stations", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Future<void> _launchMapsForPoliceStations() async {
    const query = 'police station near me';
    final url = 'https://www.google.com/maps/search/?api=1&query=$query';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
