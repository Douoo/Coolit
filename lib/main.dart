import 'package:coolit/screen/loader.dart';
import 'package:flutter/material.dart';

import 'package:coolit/theme/theme_provider.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const Coolet());
}

class Coolet extends StatefulWidget {
  const Coolet({Key? key}) : super(key: key);

  @override
  State<Coolet> createState() => _CooletState();
}

class _CooletState extends State<Coolet> {
  int _currentTime = int.parse(DateFormat('kk').format(DateTime.now()));

  bool isNight(int localTime) {
    if (localTime > 7 && localTime < 17) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coolet',
      theme: Style.themeData(isNight(_currentTime), context),
      initialRoute: LoadingScreen.route,
      routes: {
        LoadingScreen.route: (context) => LoadingScreen(),
      },
    );
  }
}
