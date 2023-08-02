import 'package:flutter/material.dart';
// ignore: must_be_immutable
class Created extends StatelessWidget {
  double ancho;
  double largo;
  Created(this.ancho, this.largo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // frame4oAR (16:51)
      //margin: EdgeInsets.fromLTRB(0, 0.15*largo, 0, 0),
      padding:const EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: double.infinity,
      //height: largo*0.15,
      child: Text(
        'Created by Bryan Daniell Arrivasplata Rojas',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 8 *largo/ancho,
          color: const Color.fromARGB(255, 185, 183, 183),
        ),
        /*style: SafeGoogleFont(
          'Roboto',
          fontSize: 10 * largo/ancho,
          //fontWeight: FontWeight.w400,
          height: 0.01 * largo/ancho,
          color: const Color(0xffe5e5e5),
        ),*/
      ),
    );
  }
}