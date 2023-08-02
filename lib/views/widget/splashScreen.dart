// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application/controller/controller.dart';
import 'package:flutter_application/models/modelos/model.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String? nombre_completo;
  late String? tipo_descripcion;
  late ListaDocente_Model facultad;
  late ListaDocente_Model curso;
  late ListaDocente_Model asistencia;
  late ListaDocente_Model perfil;
  List cursos = [];
  List asistencias = [];
  List facultades = [];
  List perfiles = [];
  

  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    double largo = MediaQuery.of(context).size.height;
    return Container(
      width: ancho,
      height: largo,
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
      ),
      child:SafeArea(
        child:Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
            const Spacer(),
            SizedBox(
              width: 0.5*ancho, 
              height: 0.30*largo, 
              child: CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 20.0,
                percent: 1.0,
                center: const Text("UNI"),
                animation: true,
                animationDuration: 1000,
                progressColor: const Color(0xff800404),
                circularStrokeCap: CircularStrokeCap.butt,
              ),
            ),
            const Spacer(),
            Text(
              'Bienvenido/Welcome',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 10 *largo/ancho,
                color: const Color.fromARGB(255, 185, 183, 183),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future llenarCursosAlumno() async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    UsuarioController usuarioController = UsuarioController();
    nombre_completo = prefs.getString('nombre_completo');
    tipo_descripcion = prefs.getString('tipo_descripcion');
    curso = await usuarioController.getCursosAlumno(prefs.getString('email'));
    asistencia = await usuarioController.getAsistenciaHoy(prefs.getString('email'));
    perfil = await usuarioController.getPerfil(prefs.getString('email'));
    //debugPrint(nombre_completo);
    return true;
    //debugPrint(usuario.response.toString());
  }
  Future llenarFacultades() async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    UsuarioController usuarioController = UsuarioController();
    nombre_completo = prefs.getString('nombre_completo');
    tipo_descripcion = prefs.getString('tipo_descripcion');
    facultad = await usuarioController.getFacultad(prefs.getString('email'));
    perfil = await usuarioController.getPerfil(prefs.getString('email'));
    return true;
    //debugPrint(usuario.response.toString());
  }
  extraerList(List <dynamic> data,List arreglo,String value,String? value_1,String? value_2,String? value_3,String? value_4,String? value_5,String? value_6){
    if(data.isNotEmpty){
      for(var x in data ){
        if(value_1!=null){
          if(value_2!=null){
            if(value_3!=null){
              if(value_4!=null){
                if(value_5!=null){
                  if(value_6!=null){
                    arreglo.add({value:x[value],value_1:x[value_1],value_2:x[value_2],value_3:x[value_3],value_4:x[value_4],value_5:x[value_5],value_6:x[value_6]});
                  }else{
                    arreglo.add({value:x[value],value_1:x[value_1],value_2:x[value_2],value_3:x[value_3],value_4:x[value_4],value_5:x[value_5]});
                  }
                }else{
                  arreglo.add({value:x[value],value_1:x[value_1],value_2:x[value_2],value_3:x[value_3],value_4:x[value_4]});
                }
              }else{
                arreglo.add({value:x[value],value_1:x[value_1],value_2:x[value_2],value_3:x[value_3]});
              }
            }else{
              arreglo.add({value:x[value],value_1:x[value_1],value_2:x[value_2]});
            }
          }else{
            arreglo.add({value:x[value],value_1:x[value_1]});       
          }
        }else{
          arreglo.add({value:x[value]});
        }
      }
    }
    
  }
  @override
  void initState(){
    super.initState();
    _initCheck();
  }
  void _initCheck() async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    cursos.clear();
    asistencias.clear();
    perfiles.clear();
    facultades.clear();
    if(prefs.getString('email') != null){
      if(prefs.getInt('tipo')==1){
        llenarCursosAlumno().then((value) {
          if(perfil.response.isNotEmpty){
            if(!perfil.response.contains('error')){
              extraerList(curso.response,cursos, 'cod_oseccion','descripcion', null, null, null, null, null);
              extraerList(asistencia.response,asistencias, 'id','descripcion_facultad','cod_curso','descripcion_curso','cod_seccion','referencia','fecha_created');
              extraerList(perfil.response,perfiles, 'codigo','primer_nombre','segundo_nombre','tercer_nombre','apellido_paterno','apellido_materno','email');
              Navigator.popAndPushNamed(context, '/asistencia',arguments: {'email':prefs.getString('email'),'tipo':prefs.getInt('tipo'),'nombre_completo':prefs.getString('nombre_completo'),'tipo_descripcion':prefs.getString('tipo_descripcion'),'cursos':cursos,'asistencias':asistencias,'perfiles':perfiles});
            }else{
              Navigator.popAndPushNamed(context,'/error');
            }
          }else{
            Navigator.popAndPushNamed(context,'/error');
          }
        });
      }else if(prefs.getInt('tipo')==2){
        llenarFacultades().then((value) {
          if(perfil.response.isNotEmpty){
            if(!perfil.response.contains('error')){
              extraerList(facultad.response,facultades, 'cod_facultad','abreviatura','descripcion', null, null, null, null);
              extraerList(perfil.response,perfiles, 'codigo','primer_nombre','segundo_nombre','tercer_nombre','apellido_paterno','apellido_materno','email');
              Navigator.popAndPushNamed(context, '/listaCursos',arguments: {'email':prefs.getString('email'),'tipo':prefs.getInt('tipo'),'nombre_completo':prefs.getString('nombre_completo'),'tipo_descripcion':prefs.getString('tipo_descripcion'),'facultades':facultades,'perfiles':perfiles});
            }else{
              Navigator.popAndPushNamed(context,'/error');
            }
          }else{
            Navigator.popAndPushNamed(context,'/error');
          }
        });
      }
    }else{
      Navigator.popAndPushNamed(context, '/login');
    }
  }
}