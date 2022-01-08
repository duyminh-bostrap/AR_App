import 'package:flutter/material.dart';
import 'package:hexAr/Unity_Screens/debug_screen.dart';
import 'package:hexAr/screens/orientation_screen.dart';

import 'menu_screen.dart';
import 'Unity_Screens/unity_screen.dart';
import 'screens/api_screen.dart';
import 'screens/loader_screen.dart';
import 'screens/simple_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Unity AR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MenuScreen(),
        // '/simple': (context) => SimpleScreen(),
        // '/loader': (context) => LoaderScreen(),
        // '/orientation': (context) => OrientationScreen(),
        // '/api': (context) => ApiScreen(),
        '/debug': (context) => DebugScreen(),
        '/unity': (context) => UnityScreen(),
      },
    );
  }
}
