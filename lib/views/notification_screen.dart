import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.redAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Notification',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '2 NEW',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildNotificationSection(
                context,
                title: 'TODAY',
                notifications: [
                  buildNotificationTile(context, 'Warning!!', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', '1h'),
                  buildNotificationTile(context, 'Warning!!', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', '1h'),
                ],
              ),
              SizedBox(height: 20),
              buildNotificationSection(
                context,
                title: 'Previous',
                notifications: [
                  buildNotificationTile(context, 'Warning!!', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', '1d'),
                  buildNotificationTile(context, 'Warning!!', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', '1d'),
                  buildNotificationTile(context, 'Warning!!', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', '3d'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNotificationSection(BuildContext context, {required String title, required List<Widget> notifications}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle "Mark all as read" action
              },
              child: Text(
                'Mark all as read',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        ),
        Column(children: notifications),
      ],
    );
  }

  Widget buildNotificationTile(BuildContext context, String title, String subtitle, String time) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.notifications_active, color: Colors.white),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.white70),
        ),
        trailing: Text(
          time,
          style: TextStyle(color: Colors.white54),
        ),
      ),
    );
  }
}
