import 'package:coolit/screen/loader.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Coolet());
}

class Coolet extends StatefulWidget {
  const Coolet({Key? key}) : super(key: key);

  @override
  State<Coolet> createState() => _CooletState();
}

class _CooletState extends State<Coolet> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coolet',
      theme: ThemeData.light(),
      initialRoute: LoadingScreen.route,
      routes: {
        LoadingScreen.route: (context) => LoadingScreen(),
      },
    );
  }
}
