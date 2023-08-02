// ignore_for_file: must_be_immutable, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application/services/authenticator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Opciones extends StatelessWidget {
  double ancho;
  double largo;
  List facultades;
  List perfiles;
  Opciones(this.ancho, this.largo,this.facultades,this.perfiles,{super.key});

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)?.settings.arguments as Map;
    
    //debugPrint(args['tipo'].toString());
    return PopupMenuButton(
      // Callback that sets the selected popup menu item.
      onSelected: (item) async {
        if(item==0){
            Navigator.pushNamed(context, '/perfil',arguments:{'perfiles':perfiles});
          }else if(item==1){
            if(facultades.isNotEmpty){
              //debugPrint(facultades.toString());
              Navigator.pushNamed(context, '/reportes',arguments:facultades);
            }
          }else if(item==2){
            await Authenticator.signOutGoogle();
            SharedPreferences.getInstance().then((prefs) => prefs.clear());
            //Navigator.push(context,route);
            Navigator.popAndPushNamed(context, '/splashScreen');
            
          }
      },
      child: const Icon(Icons.account_circle_rounded,size: 50,color: Color(0xff800404),),
      
      itemBuilder: (context) => PopMenu(args['tipo']),
      
    );
  }
  
  PopMenu(int tipo){
    List<PopupMenuEntry<int>> popMenu = [];
    popMenu.clear();
    if(tipo == 1){
      popMenu = const[
        PopupMenuItem(
          value: 0,
          child: Text('Ver Perfil'),
        ),
        PopupMenuItem(
          value: 2,
          child: Text('Cerrar Sesión'),
        ),
      ];
    }else if(tipo == 2){
      popMenu = const[
        PopupMenuItem(
          value: 0,
          child: Text('Ver Perfil'),
        ),
        PopupMenuItem(
          value: 1,
          child: Text('Ver Reportes'),
        ),
        PopupMenuItem(
          value: 2,
          child: Text('Cerrar Sesión'),
        ),
      ];
    }
    
    return popMenu;
  }
  
}