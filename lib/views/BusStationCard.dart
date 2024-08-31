import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BusStationCard extends StatelessWidget {
  final Function openMapFunc;

  const BusStationCard({required Key key, required this.openMapFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () {
                _launchMapsForBusStations();
              },
              child: Container(
                  height: 100,
                  width: 100,
                  child: Center(
                      child: Image.asset(
                        "assets/images/busstation.png",
                        height: 50,
                      ))),
            ),
          ),
          Text("Bus Stations", style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }

  Future<void> _launchMapsForBusStations() async {
    const query = 'bus stop near me';
    final url = 'https://www.google.com/maps/search/?api=1&query=$query';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
