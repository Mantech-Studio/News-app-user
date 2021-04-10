import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_user/HomePage.dart';
import 'package:news_app_user/Screens/CategoryPage.dart';

class PageControllerScreen extends StatefulWidget {
  @override
  _PageControllerScreenState createState() => _PageControllerScreenState();
}

class _PageControllerScreenState extends State<PageControllerScreen> {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          controller: controller,
          children: [
            HomePage(),
            CategoryPage(),
          ],
        ),
      ),
    );
  }
}
