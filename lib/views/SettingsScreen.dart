import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[800],
                  child: Icon(Icons.person, color: Colors.white, size: 50),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'username@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildSettingsItem(
              context,
              icon: Icons.person_outline,
              text: 'Personal Information',
              onTap: () {
                // Handle navigation
              },
            ),
            _buildSettingsItem(
              context,
              icon: Icons.lock_outline,
              text: 'Privacy & Permissions',
              onTap: () {
                // Handle navigation
              },
            ),
            _buildSettingsItem(
              context,
              icon: Icons.phone_outlined,
              text: 'Change Phone Number',
              onTap: () {
                // Handle navigation
              },
            ),
            _buildSettingsItem(
              context,
              icon: Icons.security_outlined,
              text: 'Password & Account',
              onTap: () {
                // Handle navigation
              },
            ),
            _buildSettingsItem(
              context,
              icon: Icons.shield_outlined,
              text: 'Secure Mode',
              onTap: () {
                // Handle navigation
              },
            ),
            _buildSettingsItem(
              context,
              icon: Icons.notifications_outlined,
              text: 'Always Active Notifications',
              onTap: () {
                // Navigate to Notifications screen
                Navigator.pushNamed(context, '/notifications');
              },
            ),
            _buildSettingsItem(
              context,
              icon: Icons.help_outline,
              text: 'Support',
              onTap: () {
                // Handle navigation
              },
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  // Handle logout
                },
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(BuildContext context, {required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.redAccent),
      title: Text(text, style: TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
