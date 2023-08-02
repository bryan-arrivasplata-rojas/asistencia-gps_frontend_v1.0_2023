// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, use_build_context_synchronously
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class ButtonReporte extends StatelessWidget {
  double ancho;
  double largo;
  ButtonReporte(this.ancho, this.largo, {super.key});
  @override
  Widget build(BuildContext context) {
    //Alert alertDialog = Alert();
    return Container(
      //margin: EdgeInsets.fromLTRB(40 * largo/ancho, 20 * largo/ancho, 40 * largo/ancho, 0),
      
      width: ancho,
      //height: double.maxFinite,
      child:ElevatedButton(
        onPressed: () {
          
        },
        style:ElevatedButton.styleFrom( //<-- SEE HERE
          backgroundColor: const Color(0xff800404),
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(0),
          ),
          padding: EdgeInsets.fromLTRB(0,0.02*largo,0,0.02*largo)
        ),
        child:const Text(
            'Reporte de Asistencias',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}