import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:url_launcher/url_launcher.dart';
import '../viewmodels/navigation_viewmodel.dart';
import 'LocationFetcherScreen.dart';
import 'live_tracking_screen.dart';
import 'HomeViewModel.dart';
import 'custom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel = HomeViewModel();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0), // Adds padding on the left
            child: IconButton(
              icon: Image.asset(
                'assets/images/avatar.png', // Assuming a menu icon image is provided
                height: 80, // Sets the height to 80px
                width: 80, // Ensures the width is also 80px
                fit: BoxFit.contain, // Ensures the image scales well
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ),
        drawer: buildDrawer(context),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HELLO,',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'NAINA',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Spacer(), // Pushes the image to the right
                    Image.asset(
                      'assets/images/hand_wave.png',
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      buildScrollableOption(
                        context,
                        title: 'Detector',
                        onTap: () {
                          // Navigate to Detector screen
                        },
                      ),
                      buildScrollableOption(
                        context,
                        title: 'Location',
                        onTap: () {
                          // Navigate to Location screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LocationFetcherScreen()),
                          );
                        },
                      ),
                      buildScrollableOption(
                        context,
                        title: 'Live Tracking',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LiveTrackingScreen()),
                          );
                        },
                      ),
                      buildScrollableOption(
                        context,
                        title: 'Screaming',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LiveTrackingScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      buildFeatureCardScroll(context),
                      SizedBox(height: 20),
                      buildFavoritesSection(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomNavigationBar(viewModel: NavigationViewModel()),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SAAHASINI',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[800],
                    backgroundImage: AssetImage('assets/images/avatar.png'), // Use the appropriate image asset
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Your Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.grey[700]),
                ],
              ),
            ),
            buildDrawerItem(context, Icons.edit, "Edit Profile"),
            buildDrawerItem(context, Icons.lock, "SOS Enable"),
            buildDrawerItem(context, Icons.vpn_key, "Change Password"),
            buildDrawerItem(context, Icons.notifications, "Notifications"),
            buildDrawerItem(context, Icons.settings, "Profile Settings"),
            buildDrawerItem(context, Icons.logout, "Logout"),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.redAccent),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: () {
        // Handle navigation or actions here
      },
    );
  }

  Widget buildScrollableOption(BuildContext context, {required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget buildFeatureCardScroll(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          buildFeatureCard('Spy Camera Detector', 'assets/images/tracking.png', Colors.redAccent, context),
          SizedBox(width: 10),
          buildFeatureCard('Fake Call', 'assets/images/tracking.png', Colors.redAccent, context),
          SizedBox(width: 10),
          buildFeatureCard('Live Tracking', 'assets/images/digital.png', Colors.redAccent, context),
        ],
      ),
    );
  }

  Widget buildFeatureCard(String title, String imagePath, Color color, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/call'); // Navigates to the call screen when tapped
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              offset: Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 80),
            SizedBox(height: 10),
            Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget buildFavoritesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Emergency',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle "See all" press
              },
              child: Text('See all', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        ),
        buildEmergencyListTile(
          context,
          icon: Icons.phone,
          title: 'Call Ambulance 108',
          onTap: () => _makePhoneCall('tel:108'),
        ),
        buildEmergencyListTile(
          context,
          icon: Icons.local_police,
          title: 'Call Police 100',
          onTap: () => _makePhoneCall('tel:100'),
        ),
        buildEmergencyListTile(
          context,
          icon: Icons.heart_broken,
          title: 'Call Loved Ones',
          onTap: () => _makePhoneCall('tel:+911234567890'), // Replace with actual number
        ),
      ],
    );
  }

  Widget buildEmergencyListTile(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: TextButton(
        onPressed: onTap,
        child: Text(
          'Call',
          style: TextStyle(color: Colors.redAccent, fontSize: 16),
        ),
      ),
      onTap: onTap,
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}


class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1484647939,
      appSign: '751874393a5ce84d7660387e93aabdd5f9be8e1faeaacd1ed95d9e199f6ec402',
      userID: 'Emergency Contact',
      userName: 'USER',
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    ); // ZegoUIKitPrebuiltCall
  }
}
