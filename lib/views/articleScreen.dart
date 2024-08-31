import 'package:flutter/material.dart';
import 'custom_navigation_bar.dart';
import '../viewmodels/navigation_viewmodel.dart';

class ArticleScreen extends StatelessWidget {
  final NavigationViewModel viewModel = NavigationViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'ARTICLES',
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              buildArticleCard(
                context,
                'Empowering Women: Achieving Safety and Legal Outcomes',
                'Women\'s safety is a critical issue that demands urgent attention.',
                'assets/images/article_image_1.png',
                24,
                300,
              ),
              SizedBox(height: 10),
              buildArticleCard(
                context,
                'Gender Equality and Women\'s Empowerment',
                'Gender equality is a human right. But our world faces a persistent gap in access to...',
                'assets/images/article_image_2.png',
                30,
                300,
              ),
              SizedBox(height: 10),
              buildArticleCard(
                context,
                'Kolkata rape case: India\'s top court stays abortion for rape survivor',
                'India\'s top court has ruled that a rape survivor must bear her child after she...',
                'assets/images/article_image_3.png',
                32,
                300,
              ),
              SizedBox(height: 10),

              buildArticleCard(
                context,
                'Kolkata rape case: India\'s top court stays abortion for rape survivor',
                'India\'s top court has ruled that a rape survivor must bear her child after she...',
                'assets/images/article_image_3.png',
                32,
                300,
              ),
              SizedBox(height: 10),

              buildArticleCard(
                context,
                'Kolkata rape case: India\'s top court stays abortion for rape survivor',
                'India\'s top court has ruled that a rape survivor must bear her child after she...',
                'assets/images/article_image_3.png',
                32,
                300,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(viewModel: viewModel),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),

      ),
    );
  }

  Widget buildArticleCard(BuildContext context, String title, String description, String imagePath, int comments, int likes) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(color: Colors.white70),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.comment, color: Colors.redAccent, size: 16),
                SizedBox(width: 4),
                Text('$comments comments', style: TextStyle(color: Colors.white70)),
                SizedBox(width: 16),
                Icon(Icons.thumb_up, color: Colors.redAccent, size: 16),
                SizedBox(width: 4),
                Text('$likes likes', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.favorite_border, color: Colors.white),
          onPressed: () {
            // Implement favorite functionality here
          },
        ),
        onTap: () {
          // Implement article tap functionality here
        },
      ),
    );
  }
}
