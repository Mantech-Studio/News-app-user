import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app_user/Database.dart';
import 'package:news_app_user/Screens/LoginPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ABC News'),
          actions: [
            IconButton(
              onPressed: () async {
                FirebaseDb().signout();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Center(
          child: Text('Home Page'),
        ));
  }
}
