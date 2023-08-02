// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/controller/controller.dart';
import 'package:flutter_application/models/modelos/model.dart';
import 'package:flutter_application/views/perfil/widget/informacionConfidencial.dart';
import 'package:flutter_application/views/widget/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonModificar extends StatelessWidget {
  double ancho;
  double largo;
  ButtonModificar(this.ancho, this.largo, {super.key});

  @override
  Widget build(BuildContext context) {
    UsuarioController usuarioController = UsuarioController();
    return Container(
      margin: EdgeInsets.fromLTRB(38*largo/ancho, 20, 39*largo/ancho, 0),
      padding: EdgeInsets.fromLTRB(10*largo/ancho, 10*largo/ancho, 10*largo/ancho, 10*largo/ancho),
      width: 0.6* ancho,
      //height: 0.06 * largo,
      child:ElevatedButton(
        onPressed: () async {
          if(InformacionConfidencial.passwordController.text.isNotEmpty){
            if(InformacionConfidencial.passwordConfirmatedController.text.isNotEmpty){
              if(InformacionConfidencial.passwordController.text==InformacionConfidencial.passwordConfirmatedController.text){
                SharedPreferences prefs  = await SharedPreferences.getInstance();
                String body = jsonEncode({'password':InformacionConfidencial.passwordController.text});
                ListaDocente_Model usuario = await usuarioController.putPerfil(prefs.getString('email'),body);
                //debugPrint(usuario.response.toString());
                //alerta(context,usuario.response[0]['response'].toString(),CoolAlertType.success,'Modificación');
                if(usuario.response[0]['response']==0){
                  await alert(context,'Modificación','Sus datos no se cambiaron, eran iguales a los anteriores');
                }else{
                  await alert(context,'Modificación','Sus datos fueron cambiados con éxtito');
                  InformacionConfidencial.passwordController.text = '';
                  InformacionConfidencial.passwordConfirmatedController.text = '';
                }
              }else{
                //alerta(context,'Su confirmación de contraseña no coincide con la original',CoolAlertType.warning,'Contraseña');
                await alert(context,'Información incorrecta','Su confirmación de contraseña no coincide con la original');
              }
            }else{
              //alerta(context,'Tiene que ingresar la confirmación de su contraseña',CoolAlertType.warning,'Ingresar datos');
              await alert(context,'Datos incompletos','Tiene que ingresar la confirmación de su contraseña');
            }
          }else{
            //alerta(context,'Tiene que ingresar una nueva contraseña',CoolAlertType.warning,'Ingresar datos');
            await alert(context,'Datos incompletos','Tiene que ingresar una nueva contraseña');
          }
        },
        style:ElevatedButton.styleFrom( //<-- SEE HERE
          backgroundColor: const Color(0xff800404),
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(50 * largo/ancho,
            )
          ),
        ),
        child:const Text(
            'Modificar contraseña',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}