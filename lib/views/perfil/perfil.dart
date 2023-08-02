// ignore_for_file: sort_child_properties_last, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/controller/controller.dart';
import 'package:flutter_application/models/modelos/model.dart';
import 'package:flutter_application/views/perfil/widget/informacionPersonal.dart';
import 'package:flutter_application/views/widget/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});
  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool data = false;
  late ListaDocente_Model perfil;
  static TextEditingController passwordController = TextEditingController(text:"");
  static TextEditingController passwordConfirmatedController = TextEditingController(text:"");
  UsuarioController usuarioController = UsuarioController();
  @override
  Widget build(BuildContext context) { 
    double ancho = MediaQuery.of(context).size.width;
    double largo = MediaQuery.of(context).size.height;
    Map args = ModalRoute.of(context)?.settings.arguments as Map;
    return SizedBox(
      width: ancho,
      child: Material(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          width: ancho,
          height: largo,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
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
                        'Perfil',
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
                ],
              ),
              Spacer(),
              InformacionPersonal(ancho, largo,args['perfiles']),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // frame7fn9 (39:345)
                    padding: EdgeInsets.fromLTRB(0, 8.5*largo/ancho, 0, 8.5*largo/ancho),
                    width: 310*largo/ancho,
                    decoration: const BoxDecoration (
                      color: Color(0xffffffff),
                    ),
                    child: Text(
                      'Información confidencial',
                      style: TextStyle (
                        fontSize: 12*largo/ancho,
                        fontWeight: FontWeight.w400,
                        height: 1.1725*largo/ancho,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    // password9pd (16:59)
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    padding: EdgeInsets.fromLTRB(10*largo/ancho, 2*largo/ancho, 10*largo/ancho, 2*largo/ancho),
                    //width: double.infinity,
                    width: 0.9*ancho,
                    decoration: BoxDecoration (
                      border: Border.all(color: Color(0xff800404)),
                      borderRadius: BorderRadius.circular(20*largo/ancho),
                    ),
                    child: TextField(
                      controller: passwordController,
                      //obscureText: true,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.1725,
                        color: Color(0xff800404),
                      ),
                      decoration:const InputDecoration(
                        hintText: 'Contraseña nueva',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Color.fromARGB(255, 189, 94, 94)),
                      ),
                    ),
                  ),
                  Container(
                    // password9pd (16:59)
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    padding: EdgeInsets.fromLTRB(10*largo/ancho, 2*largo/ancho, 10*largo/ancho, 2*largo/ancho),
                    //width: double.infinity,
                    width: 0.9*ancho,
                    decoration: BoxDecoration (
                      border: Border.all(color: Color(0xff800404)),
                      borderRadius: BorderRadius.circular(20*largo/ancho),
                    ),
                    child: TextField(
                      controller: passwordConfirmatedController,
                      obscureText: true,
                      style:const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.1725,
                        color: Color(0xff800404),
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Confirmar Contraseña',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Color.fromARGB(255, 189, 94, 94)),
                      ),
                    ),
                  ),
                  /*Container(
                    // buttonsesionNfs (18:330)
                    margin: EdgeInsets.fromLTRB(38*largo/ancho, 20, 39*largo/ancho, 0),
                    padding: EdgeInsets.fromLTRB(10*largo/ancho, 10*largo/ancho, 10*largo/ancho, 10*largo/ancho),
                    //width: double.infinity,
                    //height: 35.74*fem,
                    decoration: BoxDecoration (
                      color: Color(0xff800404),
                      borderRadius: BorderRadius.circular(50*largo/ancho),
                    ),
                    child: const Center(
                      child: Text(
                        'Modificar Contraseña',
                        textAlign: TextAlign.center,
                        style: TextStyle (
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          //height: 1.1725*largo/ancho,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(38*largo/ancho, 20, 39*largo/ancho, 0),
                padding: EdgeInsets.fromLTRB(10*largo/ancho, 10*largo/ancho, 10*largo/ancho, 10*largo/ancho),
                width: 0.6* ancho,
                //height: 0.06 * largo,
                child:ElevatedButton(
                  onPressed: () async {
                    if(passwordController.text.isNotEmpty){
                      if(passwordConfirmatedController.text.isNotEmpty){
                        if(passwordController.text==passwordConfirmatedController.text){
                          SharedPreferences prefs  = await SharedPreferences.getInstance();
                          String body = jsonEncode({'password':passwordController.text});
                          ListaDocente_Model usuario = await usuarioController.putPerfil(prefs.getString('email'),body);
                          //debugPrint(usuario.response.toString());
                          //alerta(context,usuario.response[0]['response'].toString(),CoolAlertType.success,'Modificación');
                          if(!usuario.response.contains('error')){
                            if(usuario.response[0]['response']==1){
                              await alert(context,'Modificación','Sus datos fueron cambiados con éxito');
                              passwordController.text = '';
                              passwordConfirmatedController.text = '';
                            }else{
                              await alert(context,'Modificación','Sus datos no se cambiaron, eran iguales a los anteriores');
                            }
                          }else{
                            await alert(context,'Error','Comunique a Soporte Técnico e intente nuevamente mas tarde');
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
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}