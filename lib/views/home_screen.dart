import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:url_launcher/url_launcher.dart';
import '../viewmodels/navigation_viewmodel.dart';
import 'live_tracking_screen.dart';
import 'HomeViewModel.dart';
import 'custom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel = HomeViewModel();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AudioPlayer _audioPlayer = AudioPlayer();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a gradient for the screen background
    final Gradient gradient = LinearGradient(
      colors: [Colors.deepPurple.shade900, Colors.black],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return Container(
      decoration: BoxDecoration(
        gradient: gradient, // Apply the gradient to the screen background
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent, // Keep the background transparent to show the gradient
        drawer: buildDrawer(context), // Keep the drawer functionality
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row with the avatar and "HELLO, NAINA"
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: CircleAvatar(
                        radius: 30, // Increase the size of the avatar
                        backgroundColor: Colors.grey[800],
                        child: CircleAvatar(
                          radius: 28, // Slightly smaller to create a border effect
                          backgroundImage: AssetImage('assets/images/avatar.png'),
                        ),
                      ),
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/images/hand_wave.png',
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HELLO,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'NAINA',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 38,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                        title: 'Live Tracking',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationPage()),
                          );
                        },
                      ),
                      buildScrollableOption(
                        context,
                        title: 'Screaming',
                        onTap: () {
                          // Handle Screaming screen navigation or action
                        },
                      ),
                      buildScrollableOption(
                        context,
                        title: 'Screaming',
                        onTap: () {
                          // Handle Screaming screen navigation or action
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.6), Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
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
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 2),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[800],
                    backgroundImage: AssetImage('assets/images/avatar.png'),
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
            buildDrawerItem(context, Icons.edit, "Edit Profile", () {
              // Handle Edit Profile navigation or action
            }),
            buildDrawerItem(context, Icons.lock, "SOS Enable", () {
              // Handle SOS Enable navigation or action
            }),
            buildDrawerItem(context, Icons.vpn_key, "Change Password", () {
              // Handle Change Password navigation or action
            }),
            buildDrawerItem(context, Icons.notifications, "Notifications", () {
              // Handle Notifications navigation or action
            }),
            buildDrawerItem(context, Icons.settings, "Profile Settings", () {
              // Handle Profile Settings navigation or action
            }),
            buildDrawerItem(context, Icons.logout, "Logout", () {
              // Handle Logout navigation or action
            }),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.redAccent.withOpacity(0.8)),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: onTap,
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
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
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
          buildFeatureCard('Fake Call', 'assets/images/call.png', context),
          SizedBox(width: 10),
          buildFeatureCard('Siren', 'assets/images/siren.png', context),
          SizedBox(width: 10),
          buildFeatureCard('Camera Detector', 'assets/images/tracking.png', context),
        ],
      ),
    );
  }

  Widget buildFeatureCard(String title, String imagePath, BuildContext context) {
    return InkWell(
      onTap: () {
        if (title == 'Siren') {
          _audioPlayer.play(AssetSource('audio/siren.mp3'));
        }
        if(title =='Fake Call'){
          Navigator.pushNamed(context, '/call');

        }
        if(title =='Camera Detector'){
          Navigator.pushNamed(context, '/spycam');
        }

      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.black, // Set the background color to black
          borderRadius: BorderRadius.circular(16), // Rounded corners
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)), // Top rounded corners
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover, // Cover the container with the image
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black, // Keep the black background for the text section
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)), // Bottom rounded corners
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white, // White text color
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
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
                fontFamily: 'Poppins',
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
          title: 'Call Ambulance',
          onTap: () =>
              FlutterPhoneDirectCaller.callNumber('+919318440480')
          ,
        ),
        buildEmergencyListTile(
          context,
          icon: Icons.local_police,
          title: 'Call Police',
          onTap: () => FlutterPhoneDirectCaller.callNumber('+919318440480'),
        ),
        buildEmergencyListTile(
          context,
          icon: Icons.contact_mail_rounded,
          title: 'Call Loved Ones',
          onTap: () => FlutterPhoneDirectCaller.callNumber('+919318440480'), // Replace with actual number
        ),
      ],
    );
  }

  Widget buildEmergencyListTile(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
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
      appSign:
      '751874393a5ce84d7660387e93aabdd5f9be8e1faeaacd1ed95d9e199f6ec402',
      userID: 'Emergency Contact',
      userName: 'USER',
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}