// ignore_for_file: must_be_immutable, unused_local_variable, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'package:flutter/material.dart';

class InformacionPersonal extends StatelessWidget {
  double ancho;
  double largo;
  List perfiles;
  InformacionPersonal(this.ancho, this.largo,this.perfiles,{super.key});
  
  @override
  Widget build(BuildContext context) {
    //debugPrint(perfiles[0].toString());
    String nombre_completo = 'default';
    String apellidos = 'default';
    apellidos = perfiles[0]['apellido_paterno'].toString() +' '+ perfiles[0]['apellido_materno'].toString();
    if(perfiles[0]['segundo_nombre'].toString().isNotEmpty){
      if(perfiles[0]['tercer_nombre'].toString().isNotEmpty){
        nombre_completo = perfiles[0]['primer_nombre'].toString() +' '+ perfiles[0]['segundo_nombre'].toString() +' '+ perfiles[0]['tercer_nombre'].toString();
      }else{
        nombre_completo = perfiles[0]['primer_nombre'].toString() +' '+ perfiles[0]['segundo_nombre'].toString();
      }
    }else{
      nombre_completo = perfiles[0]['primer_nombre'].toString();
    }
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
            'Información personal',
            style: TextStyle (
              fontSize: 12*largo/ancho,
              fontWeight: FontWeight.w400,
              height: 1.1725*largo/ancho,
              color: const Color(0xff000000),
            ),
          ),
        ),
        Container(
          // seleccionarcurso7u3 (39:360)
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          padding: EdgeInsets.fromLTRB(10*largo/ancho, 8*largo/ancho, 10*largo/ancho, 8*largo/ancho),
          width: 0.9*ancho,
          decoration: BoxDecoration (
            border: Border.all(color: Color(0xff800404)),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            perfiles[0]['codigo'].toString(),
            style: TextStyle (
              fontSize: 12*largo/ancho,
              fontWeight: FontWeight.w400,
              //height: 1.1725*largo/ancho,
              color: const Color(0xff800404),
            ),
          ),
        ),
        Container(
          // seleccionarcurso7u3 (39:360)
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          padding: EdgeInsets.fromLTRB(10*largo/ancho, 8*largo/ancho, 10*largo/ancho, 8*largo/ancho),
          width: 0.9*ancho,
          decoration: BoxDecoration (
            border: Border.all(color: Color(0xff800404)),
            borderRadius: BorderRadius.circular(20*largo/ancho),
          ),
          child: Text(
            nombre_completo,
            style: TextStyle (
              fontSize: 12*largo/ancho,
              fontWeight: FontWeight.w400,
              color: const Color(0xff800404),
            ),
          ),
        ),
        Container(
          // seleccionarcurso7u3 (39:360)
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          padding: EdgeInsets.fromLTRB(10*largo/ancho, 8*largo/ancho, 10*largo/ancho, 8*largo/ancho),
          width: 0.9*ancho,
          decoration: BoxDecoration (
            border: Border.all(color: Color(0xff800404)),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            apellidos,
            style: TextStyle (
              fontSize: 12*largo/ancho,
              fontWeight: FontWeight.w400,
              //height: 1.1725*largo/ancho,
              color: const Color(0xff800404),
            ),
          ),
        ),
        Container(
          // seleccionarcurso7u3 (39:360)
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          padding: EdgeInsets.fromLTRB(10*largo/ancho, 8*largo/ancho, 10*largo/ancho, 8*largo/ancho),
          width: 0.9*ancho,
          decoration: BoxDecoration (
            border: Border.all(color: Color(0xff800404)),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            perfiles[0]['email'].toString(),
            style: TextStyle (
              fontSize: 12*largo/ancho,
              fontWeight: FontWeight.w400,
              //height: 1.1725*largo/ancho,
              color: const Color(0xff800404),
            ),
          ),
        ),
      ],
    );
  }
}