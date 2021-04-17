import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_user/HomePage.dart';
import 'package:news_app_user/Screens/BlogPage.dart';
import 'package:news_app_user/Screens/CricketnewsPage.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CategoryButton('All-News', 'bbc-news'),
        CategoryButton('business', 'business'),
        CategoryButton('entertainment', 'entertainment'),
        CategoryButton('general', 'general'),
        CategoryButton('health', 'health'),
        CategoryButton('science', 'science'),
        CategoryButton('sports', 'sports'),
        CategoryButton('technology', 'technology'),
        FlatButton(
          color: Colors.blueAccent,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NationalPage()),
            );
          },
          child: Text('Blog News'),
        ),
        FlatButton(
          color: Colors.blueAccent,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CricketNews()),
            );
          },
          child: Text('Cricket News'),
        ),
      ],
    ));
  }
}

class CategoryButton extends StatelessWidget {
  String title;
  String category;
  CategoryButton(this.title, this.category);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.blueAccent,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => HomePage(
                    category: category,
                  )),
        );
      },
      child: Text(title),
    );
  }
}
