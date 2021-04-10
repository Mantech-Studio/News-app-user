import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_user/HomePage.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ABC News'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlatButton(
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            category: 'entertainment',
                          )),
                );
              },
              child: Text('entertainment'),
            ),
            FlatButton(
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            category: 'business',
                          )),
                );
              },
              child: Text('business'),
            ),
          ],
        ));
  }
}
