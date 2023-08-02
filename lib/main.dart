import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/views/widget/router_generator.dart';
import 'package:flutter_application/views/widget/splashScreen.dart';
import 'package:flutter_application/views/widget/splashScreenHome.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xff800404),
    systemNavigationBarColor: Color(0xff800404),
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      home:const SplashScreenHome(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
