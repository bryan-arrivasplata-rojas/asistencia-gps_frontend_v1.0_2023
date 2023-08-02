// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application/views/widget/alert.dart';
class ListWidget extends StatelessWidget {
  List usuarios;
  ListWidget(this.usuarios, {super.key});
  List<Widget> widgets = [];
  @override
  Widget build(BuildContext context) {
    widgets.clear();
    //debugPrint(usuarios.toString());
    if (usuarios.isNotEmpty){
      for(var x in usuarios ){
        widgets.add(
          Material(
            type: MaterialType.transparency,
            child:ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(x['nombre_completo']),
              subtitle: Text(x['email']),
              //enabled: true,
              //hoverColor: const Color.fromARGB(255, 161, 14, 14),
              onTap: ()async{
                //alerta(context,x['codigo'].toString(),CoolAlertType.success,'Código institucional');
                await alert(context,'Código institucional',x['codigo'].toString());
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