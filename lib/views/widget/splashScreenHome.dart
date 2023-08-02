// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: must_be_immutable
class SplashScreenHome extends StatefulWidget {
  const SplashScreenHome({super.key});

  @override
  State<SplashScreenHome> createState() => _SplashScreenHomeState();
}

class _SplashScreenHomeState extends State<SplashScreenHome> {
  @override
  void initState(){
    super.initState();
    _initCheck();
  }
  void _initCheck() async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    if(prefs.getString('email') != null){
      Navigator.popAndPushNamed(context, '/splashScreen');
    }else{
      Timer(
        const Duration(milliseconds: 1500),()=> Navigator.popAndPushNamed(context, '/login')
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    double largo = MediaQuery.of(context).size.height;
    return Container(
      width: ancho,
      height: largo,
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
      ),
      child:SafeArea(
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child:Container(
                // logouniiSV (18:79)
                //padding: EdgeInsets.fromLTRB(0, 0.1*largo, 0, 0.1*largo),
                width: 120*largo/ancho,
                height: 152*largo/ancho,
                decoration: const BoxDecoration (
                  color: Color(0xffffffff),
                ),
                child: Image.asset(
                  'assets/logouni.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}