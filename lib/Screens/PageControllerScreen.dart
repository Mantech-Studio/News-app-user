import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_user/Database.dart';
import 'package:news_app_user/HomePage.dart';
import 'package:news_app_user/Screens/BlogPage.dart';
import 'package:news_app_user/Screens/CategoryPage.dart';
import 'package:news_app_user/Screens/CovidDataPage.dart';
import 'package:news_app_user/Screens/CricketnewsPage.dart';
import 'package:news_app_user/Screens/EntertainmentPage.dart';
import 'package:news_app_user/Screens/FashionPage.dart';
import 'package:news_app_user/Screens/InternationalPage.dart';
import 'package:news_app_user/Screens/LoginPage.dart';
import 'package:news_app_user/Screens/PoliticsPage.dart';
import 'package:news_app_user/Screens/SportsPage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:news_app_user/Screens/WeatherPage.dart';

class PageControllerScreen extends StatefulWidget {
  @override
  _PageControllerScreenState createState() => _PageControllerScreenState();
}

class _PageControllerScreenState extends State<PageControllerScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size(MediaQuery.of(context).size.width.toDouble(), 80),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text('ABC News'),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await FirebaseDb().signout();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.thermostat,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    Position position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.low);
                    print(position.latitude.toString() +
                        ', ' +
                        position.longitude.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherPage(position)));
                  },
                ),
              ],
              bottom: TabBar(
                labelColor: Colors.white,
                isScrollable: true,
                physics: ScrollPhysics(),
                tabs: <Widget>[
                  Tab(
                    text: 'National',
                  ),
                  Tab(
                    child: Container(
                      child: Text('InterNational'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text('Fashion'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text('Entertainment'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text('Politics'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Text('Covid Data'),
                    ),
                  ),
                  // Tab(
                  //   child: Container(
                  //     child: Text('Horoscope'),
                  //   ),
                  // ),
                  // Tab(
                  //   child: Container(
                  //     child: Text('Sudoku'),
                  //   ),
                  // ),
                  // Tab(
                  //   child: Container(
                  //     child: Text('Lifestyle'),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            physics: ScrollPhysics(),
            children: <Widget>[
              NationalPage(),
              InternationalPage(),
              FashionPage(),
              EntertainmentPage(),
              PoliticsPage(),
              CovidDataPage(),
            ],
          )),
    );
  }
}
