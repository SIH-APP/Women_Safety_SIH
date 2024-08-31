import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../viewmodels/navigation_viewmodel.dart';
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
                    Spacer(),  // Pushes the image to the right
                    Image.asset(
                      'assets/images/hand_wave.png',
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildCategoryItem(context, 'Detector', isSelected: true),
                    buildCategoryItem(context, 'Location'),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LiveTrackingScreen()),
                        );
                      },
                      child: buildCategoryItem(context, 'Live Tracking', isSelected: true),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      buildFeatureCardScroll(),
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

  Widget buildCategoryItem(BuildContext context, String title, {bool isSelected = false}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.redAccent : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (isSelected)
          Container(
            margin: EdgeInsets.only(top: 4),
            height: 2,
            width: 30,
            color: Colors.redAccent,
          )
      ],
    );
  }

  Widget buildFeatureCardScroll() {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          buildFeatureCard('Spy Camera Detector', 'assets/images/safety.png', Colors.deepPurpleAccent),
          SizedBox(width: 10),
          buildFeatureCard('Emergency Contact', 'assets/images/tracking.png', Colors.blueAccent),
          SizedBox(width: 10),
          buildFeatureCard('Live Tracking', 'assets/images/digital.png', Colors.orangeAccent),
        ],
      ),
    );
  }

  Widget buildFeatureCard(String title, String imagePath, Color color) {
    return Container(
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
          Image.asset(imagePath, height: 80, color: Colors.white),
          SizedBox(height: 10),
          Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
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
        ListTile(
          leading: Icon(Icons.phone, color: Colors.blue),
          title: Text('Fake call', style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CallPage(
                  callID: "fake_call_${DateTime.now().millisecondsSinceEpoch}",
                ),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.feedback, color: Colors.redAccent),
          title: Text('Education Feedback', style: TextStyle(color: Colors.white)),
        ),
        ListTile(
          leading: Icon(Icons.code, color: Colors.redAccent),
          title: Text('Code Generation', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
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
      userID: 'Fake Call',
      userName: 'USER',
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    ); // ZegoUIKitPrebuiltCall
  }
}
