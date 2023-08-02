// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application/views/asistencia/asistencia.dart';
import 'package:flutter_application/views/listacursos/listaCursos.dart';
import 'package:flutter_application/views/login/login.dart';
import 'package:flutter_application/views/perfil/perfil.dart';
import 'package:flutter_application/views/reportes/reportes.dart';
import 'package:flutter_application/views/widget/splashScreen.dart';

class RouteGenerator{
  static Route <dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch (settings.name){
      case '/login':
        return MaterialPageRoute(
          builder: (context)=>const Login(),
          settings: RouteSettings(arguments: args),
        );
      case '/splashScreen':
        return MaterialPageRoute(
          builder: (context)=>const SplashScreen(),
          settings: RouteSettings(arguments: args),
        );
      case '/perfil':
        return MaterialPageRoute(
          builder: (context)=>const Perfil(),
          settings: RouteSettings(arguments: args),
        );
      case '/listaCursos':
        return MaterialPageRoute(
          builder: (context)=>const ListaCursos(),
          settings: RouteSettings(arguments: args),
        );
      case '/asistencia':
        return MaterialPageRoute(
          builder: (context)=>const Asistencia(),
          settings: RouteSettings(arguments: args),
        );
      case '/reportes':
        return MaterialPageRoute(
          builder: (context)=>const Reportes(),
          settings: RouteSettings(arguments: args),
        );
      case '/error':
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (context){
      return const Scaffold(
        body: Center(child: Text('Contactar con Soporte Técnico')),
      );
    });
  }
}