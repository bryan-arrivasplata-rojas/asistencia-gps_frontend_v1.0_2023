// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/controller/controller.dart';
import 'package:flutter_application/services/authenticator.dart';
import 'package:flutter_application/views/login/widget/email.dart';
import 'package:flutter_application/views/widget/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: must_be_immutable
class IconInicio extends StatelessWidget {
  double ancho;
  double largo;
  IconInicio(this.ancho, this.largo, {super.key});

  @override
  Widget build(BuildContext context) {
    UsuarioController usuarioController = UsuarioController();
    return Container(
      // googlexvV (16:65)
      margin:EdgeInsets.fromLTRB(0, 0.02*largo, 0, 0),
      child: TextButton(
        onPressed: () async{
          await Firebase.initializeApp();
          User? user = await Authenticator.iniciarSesion(
            context: context
          );
          if(user?.emailVerified==true){
            var usuario = await usuarioController.getUsuario(user?.email??'');
            if(usuario.response.isNotEmpty){
              if(!usuario.response.contains('error')){
                if(user?.email==usuario.response[0]['email']){
                  guardar_datos(usuario.response[0]['email'],usuario.response[0]['tipo'],usuario.response[0]['nombre_completo'],usuario.response[0]['descripcion']);
                  Navigator.popAndPushNamed(context,'/splashScreen');
                }else{
                  //alerta(context,'Su contraseña es incorrecta',CoolAlertType.warning,'Contraseña');
                  await alert(context,'Información incorrecta','Comunique a Soporte Técnico que su cuenta no existe e intente nuevamente mas tarde');
                }
              }else{
                await alert(context,'Error','Comunique a Soporte Técnico e intente nuevamente mas tarde');
              }
              
            }else{
              //alerta(context,usuario.response[0]['error'],CoolAlertType.error,'Email');
              await alert(context,'Información incorrecta','El email no existe, contactar a soporte tecnico para agregarlo');
            }
          }else{
            //print('Cuenta no habilitada para iniciar sesión');
            await alert(context,'Error','No ha seleccionado ninguna cuenta para iniciar sesión');
          }
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: SizedBox(
          width: 50 * largo/ancho,
          height: 50 * largo/ancho,
          child: Image.asset(
            'assets/google.png',
            fit: BoxFit.cover,
          ),
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