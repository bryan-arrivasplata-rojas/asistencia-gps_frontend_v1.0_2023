// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';



class InformacionConfidencial extends StatelessWidget {
  double ancho;
  double largo;
  InformacionConfidencial(this.ancho, this.largo,{super.key});
  static TextEditingController passwordController = TextEditingController(text:"");
  static TextEditingController passwordConfirmatedController = TextEditingController(text:"");
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // frame7fn9 (39:345)
          padding: EdgeInsets.fromLTRB(0, 8.5*largo/ancho, 0, 8.5*largo/ancho),
          width: 310*largo/ancho,
          decoration: const BoxDecoration (
            color: Color(0xffffffff),
          ),
          child: Text(
            'Información confidencial',
            style: TextStyle (
              fontSize: 12*largo/ancho,
              fontWeight: FontWeight.w400,
              height: 1.1725*largo/ancho,
              color: const Color(0xff000000),
            ),
          ),
        ),
        Container(
          // password9pd (16:59)
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          padding: EdgeInsets.fromLTRB(10*largo/ancho, 2*largo/ancho, 10*largo/ancho, 2*largo/ancho),
          //width: double.infinity,
          width: 0.9*ancho,
          decoration: BoxDecoration (
            border: Border.all(color: Color(0xff800404)),
            borderRadius: BorderRadius.circular(20*largo/ancho),
          ),
          child: TextField(
            controller: passwordController,
            //obscureText: true,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.1725,
              color: Color(0xff800404),
            ),
            decoration:const InputDecoration(
              hintText: 'Contraseña nueva',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Color.fromARGB(255, 189, 94, 94)),
            ),
          ),
        ),
        Container(
          // password9pd (16:59)
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          padding: EdgeInsets.fromLTRB(10*largo/ancho, 2*largo/ancho, 10*largo/ancho, 2*largo/ancho),
          //width: double.infinity,
          width: 0.9*ancho,
          decoration: BoxDecoration (
            border: Border.all(color: Color(0xff800404)),
            borderRadius: BorderRadius.circular(20*largo/ancho),
          ),
          child: TextField(
            controller: passwordConfirmatedController,
            obscureText: true,
            style:const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.1725,
              color: Color(0xff800404),
            ),
            decoration: const InputDecoration(
              hintText: 'Confirmar Contraseña',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Color.fromARGB(255, 189, 94, 94)),
            ),
          ),
        ),
        /*Container(
          // buttonsesionNfs (18:330)
          margin: EdgeInsets.fromLTRB(38*largo/ancho, 20, 39*largo/ancho, 0),
          padding: EdgeInsets.fromLTRB(10*largo/ancho, 10*largo/ancho, 10*largo/ancho, 10*largo/ancho),
          //width: double.infinity,
          //height: 35.74*fem,
          decoration: BoxDecoration (
            color: Color(0xff800404),
            borderRadius: BorderRadius.circular(50*largo/ancho),
          ),
          child: const Center(
            child: Text(
              'Modificar Contraseña',
              textAlign: TextAlign.center,
              style: TextStyle (
                fontSize: 16,
                fontWeight: FontWeight.w400,
                //height: 1.1725*largo/ancho,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ),*/
      ],
    );
  }
}