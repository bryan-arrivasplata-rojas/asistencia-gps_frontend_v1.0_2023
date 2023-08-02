// ignore_for_file: unused_local_variable, non_constant_identifier_names, use_build_context_synchronously, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_application/models/modelos/model.dart';
import 'package:flutter_application/views/reportes/widget/comboOpciones.dart';
class Reportes extends StatefulWidget {
  const Reportes({super.key});
  @override
  State<Reportes> createState() => _ReportesState();
}

class _ReportesState extends State<Reportes> {
  late ListaDocente_Model facultad;
  late String? nombre_completo;
  late String? tipo_descripcion;
  bool data = false;
  List facultades = [];
  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    double largo = MediaQuery.of(context).size.height;
    facultades = ModalRoute.of(context)!.settings.arguments as List;
    return SizedBox(
    //width: ancho,
      width: ancho,
      height: largo,
      child: Material(
        child: Container(
          width: ancho,
          height: largo,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              // ignore: prefer_const_constructors
              Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: 
                        FloatingActionButton.small(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          backgroundColor:const Color(0xff800404),
                          child: const Icon(
                            Icons.west_rounded,
                          ),
                        ),
                    ),
                    Expanded(
                      flex: 10,
                      child:Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Reportes',
                          textAlign: TextAlign.center,
                          style: TextStyle (
                            fontSize: 30*largo/ancho,
                            fontWeight: FontWeight.w700,
                            //height: 1.1725*largo/ancho,
                            color: const Color(0xff800404),
                          ),
                        ),
                      ),
                    ),
                    //const Opciones(),
                  ],
                ),
              ),
              ComboOpciones(facultades),
              //const Spacer(),
              //const OpcionesAsistencia(),
              //const Spacer(),
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
    facultades.clear();
  }
}