import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WeatherPage extends StatefulWidget {
  Position position;
  WeatherPage(this.position);
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Weather Page')),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(widget.position.latitude.toString()),
          Text(widget.position.longitude.toString())
        ])));
  }
}
