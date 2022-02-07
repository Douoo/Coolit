import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  static const String route = 'home';
  @override
  State<LoadingScreen> createState() => _MyHomePageState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future getLocationData() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorWidget(),
          ));
    }
  }

  Future getData() async {
    WeatherModel weather = WeatherModel();
    var data = await weather.getLocationWeather();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(
            weatherData: data,
          ),
        ),
        (route) => false);
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitDoubleBounce(
        color: Colors.black,
        size: 100.0,
      )),
    );
  }
}
