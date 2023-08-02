// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application/models/modelos/model.dart';
import 'package:flutter_application/views/asistencia/widget/comboOpcionesAsistencia.dart';
import 'package:flutter_application/views/widget/opciones.dart';
class Asistencia extends StatefulWidget {

  const Asistencia({super.key});
  //const ComboOpciones(this.facultades, {super.key});
  // ignore: prefer_typing_uninitialized_variables
  //final List facultades;
  @override
  State<Asistencia> createState() => _AsistenciaState();

}
//bool ivisible = false;
class _AsistenciaState extends State<Asistencia> {
  late ListaDocente_Model asistencia;
  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    double largo = MediaQuery.of(context).size.height;
    //final args = ModalRoute.of(context)!.settings.arguments as AlumnoArguments;
    Map args = ModalRoute.of(context)?.settings.arguments as Map;
    return Material(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          // ignore: prefer_const_constructors
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text('Bienvenido: ${args['tipo_descripcion']}',
                    //'Bienvenido: $tipo_descripcion',
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(
                      args['nombre_completo'],
                      //nombre_completo.toString(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 15.0),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Opciones(ancho,largo,const [],args['perfiles']),
            ],
          ),
          // ignore: prefer_const_constructors
          //const Spacer(),
          
          ComboOpcionesAsistencia(args['cursos'],args['asistencias']),//activar
        ],
      ),
    );
  }
}