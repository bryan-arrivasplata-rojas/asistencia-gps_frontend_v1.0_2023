// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application/views/widget/alert.dart';

class ListWidgetAsistencia extends StatelessWidget {
  List asistencias;
  ListWidgetAsistencia(this.asistencias, {super.key});
  List<Widget> widgets = [];
  @override
  Widget build(BuildContext context) {
    //debugPrint(asistencias.toString());
    widgets.clear();
    //debugPrint(asistencias.toString());
    if (asistencias.isNotEmpty){
      for(var x in asistencias ){
        widgets.add(
          Material(
            type: MaterialType.transparency,
            child:ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(x['descripcion_curso']),
              subtitle: Text('${x['cod_curso']}${x['cod_seccion']} - ${x['referencia']}'),
              //enabled: true,
              //hoverColor: const Color.fromARGB(255, 161, 14, 14),
              onTap: ()async{
                //alerta(context,x['descripcion_curso'].toString(),CoolAlertType.success,'Código institucional');
                await alert(context,'Información de asistencia','El curso de ${x['descripcion_curso']} fue marcado en la fecha de ${x['fecha_created']}');
              },
            ),
          ),
        );
      }
      return ListView(
        children: widgets,
      );
    }else{
      return ListView(
        children: widgets,
      );
    }
  }
}