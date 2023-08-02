// ignore_for_file: unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, unneceheightssary_null_comparison, await_only_futures, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_application/views/listacursos/widget/comboOpciones.dart';
import 'package:flutter_application/views/widget/opciones.dart';
class ListaCursos extends StatefulWidget {
  const ListaCursos({super.key});
  @override
  State<ListaCursos> createState() => _ListaCursosState();
}

class _ListaCursosState extends State<ListaCursos>{
  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    double largo = MediaQuery.of(context).size.height;
    Map args = ModalRoute.of(context)?.settings.arguments as Map;
    //debugPrint(args['facultades'].toString());
    return SizedBox(
    //width: ancho,
      child: Material(
        child: Container(
          width: ancho,
          //height: largo,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              // ignore: prefer_const_constructors
              Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        margin:const EdgeInsets.fromLTRB(5,0,0, 0),
                        //width: ancho*0.5,
                        child:Text(
                          'Bienvenido: ${args['tipo_descripcion']}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin:const EdgeInsets.fromLTRB(5,0,0, 0),
                        //width: ancho*0.5,
                        child:Text(
                          '${args['nombre_completo']}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Opciones(ancho,largo,args['facultades'],args['perfiles']),
                ],
              ),
              // ignore: prefer_const_constructors
              ComboOpciones(args['facultades']),
              const Spacer(),
              //const OpcionesAsistencia(),
              const Spacer(),
              //ButtonReporte(ancho, largo),
            ],
          ),
        ),
      ),
    );  
  }
  @override
  void initState() {
    super.initState();
  }
}