// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/controller/controller.dart';
import 'package:flutter_application/views/login/widget/email.dart';
import 'package:flutter_application/views/login/widget/password.dart';
import 'package:flutter_application/views/widget/alert.dart';
import 'package:flutter_application/views/widget/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: must_be_immutable
class ButtonInicio extends StatelessWidget {
  double ancho;
  double largo;
  MaterialPageRoute route = MaterialPageRoute(builder: (context)=>const SplashScreen());
  ButtonInicio(this.ancho, this.largo, {super.key});
  @override
  Widget build(BuildContext context) {
    UsuarioController usuarioController = UsuarioController();
    //Alert alertDialog = Alert();
    return Container(
      margin: EdgeInsets.fromLTRB(40 * largo/ancho, 20 * largo/ancho, 40 * largo/ancho, 0),
      width: 0.6* ancho,
      //height: 0.06 * largo,
      child:ElevatedButton(
        onPressed: () async {
          if(Email.emailController.text.isNotEmpty){
            if(Password.passwordController.text.isNotEmpty){
              var usuario = await usuarioController.getUsuario(Email.emailController.text);
              //debugPrint(usuario.response.toString());
              if(usuario.response.isNotEmpty){
                if(!usuario.response.contains('error')){
                  if(Password.passwordController.text==usuario.response[0]['password']){
                    guardar_datos(usuario.response[0]['email'],usuario.response[0]['tipo'],usuario.response[0]['nombre_completo'],usuario.response[0]['descripcion']);
                    Email.emailController.text = '';
                    Password.passwordController.text = '';
                    Navigator.popAndPushNamed(context,'/splashScreen');
                  }else{
                    //alerta(context,'Su contraseña es incorrecta',CoolAlertType.warning,'Contraseña');
                    await alert(context,'Información incorrecta','Su contraseña es incorrecta');
                  }
                }else{
                  await alert(context,'Error','Comunique a Soporte Técnico e intente nuevamente mas tarde');
                }
                
              }else{
                //alerta(context,usuario.response[0]['error'],CoolAlertType.error,'Email');
                await alert(context,'Información incorrecta','El email no existe, contactar a soporte tecnico para agregarlo');
              }
            }else{
              //alerta(context,'Tiene que ingresar una contraseña',CoolAlertType.warning,'Datos incompletos');
              await alert(context,'Datos incompletos','Tiene que ingresar una contraseña');
            }
          }else{
            //alerta(context,'Tiene que ingresar un correo',CoolAlertType.warning,'Datos incompletos');
            await alert(context,'Datos incompletos','Tiene que ingresar un correo');
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
            'Iniciar Sesión',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
  // ignore: non_constant_identifier_names
  Future<void> guardar_datos(email,tipo,nombre_completo,descripcion) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email',email);
    prefs.setInt('tipo',tipo);
    prefs.setString('nombre_completo',nombre_completo);
    prefs.setString('tipo_descripcion',descripcion);
  }
}