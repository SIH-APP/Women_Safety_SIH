import 'package:flutter/material.dart';
import '../viewmodels/navigation_viewmodel.dart';
import 'SettingsScreen.dart';
import 'live_tracking_screen.dart';
import 'notification_screen.dart';
import 'HomeViewModel.dart';
import 'custom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel = HomeViewModel();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/menu_icon.png', // Assuming a menu icon image is provided
            color: Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HELLO,',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'NAINA',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Image.asset(
              'assets/images/hand_wave.png',
              height: 28,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
              radius: 24,
            ),
          ),
        ],
      ),
      drawer: buildDrawer(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/pattern.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SAAHASINI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[800],
                    child: Icon(Icons.person, color: Colors.white, size: 50),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            buildDrawerItem(context, Icons.edit, "Edit Profile"),
            buildDrawerItem(context, Icons.lock, "SOS Enable"),
            buildDrawerItem(context, Icons.vpn_key, "Change Password"),
            buildDrawerItem(context, Icons.notifications, "Notifications", '/notifications'),
            buildDrawerItem(context, Icons.settings, "Profile Settings"),
            buildDrawerItem(context, Icons.logout, "Logout"),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerItem(BuildContext context, IconData icon, String title, [String? route]) {
    return ListTile(
      leading: Icon(icon, color: Colors.redAccent),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
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
          leading: Icon(Icons.phone, color: Colors.redAccent),
          title: Text('Fake call', style: TextStyle(color: Colors.white)),
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