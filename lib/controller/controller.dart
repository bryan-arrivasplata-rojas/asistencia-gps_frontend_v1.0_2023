// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations
import 'package:flutter_application/services/peticiones.dart';
import 'package:flutter_application/models/abstracts/abstract.dart';
import 'package:flutter_application/models/modelos/model.dart';
class UsuarioController extends UsuarioGateway{
  //String path = 'https://817c-179-6-13-42.ngrok.io';
  //String path = 'https://nodejs-v16-17-0-restapi-v1-0-2023-07us.onrender.com';//'http://192.168.6.128:3000'
  //String path = 'https://restapi-flutter-nodejs-v16-17-0-v1-0.onrender.com';
  String path = 'http://localhost:3000';

  //USUARIO
  @override
  Future<ListaDocente_Model> getUsuario(String email) async {
    return HTTPApi.httpGet(path,'/usuario/','$email');
  }
  
  //PERFIL
  @override
  Future<ListaDocente_Model> getPerfil(String? email) async {
    return HTTPApi.httpGet(path,'/perfil/','$email');
  }
  @override
  Future<ListaDocente_Model> putPerfil(String? email, String? body) async {
    return HTTPApi.httpPut(path,'/perfil/','$email','$body');
  }

  //CLASES
  @override
  Future<ListaDocente_Model> getFacultad(String? email) async{
    return HTTPApi.httpGet(path,'/clases/facultad/','$email');
  }
  @override
  Future<ListaDocente_Model> getAula(int? cod_facultad) async{
    return HTTPApi.httpGet(path,'/clases/aula/','$cod_facultad');
  }
  @override
  Future<ListaDocente_Model> getCursos(String? email, int? cod_facultad) async {
    return HTTPApi.httpGet(path,'/clases/curso/','$email&$cod_facultad');
  }
  
  @override
  Future<ListaDocente_Model> getSecciones(String? email, int? cod_facultad, String? cod_curso) async {
    return HTTPApi.httpGet(path,'/clases/seccion/','$email&$cod_facultad&$cod_curso');
  }
  @override
  Future<ListaDocente_Model> getSemanas() async {
    return HTTPApi.httpGet(path,'/clases/semanas/',null);
  }

  @override
  Future<ListaDocente_Model> getSemanaHabilitada(String? email, int? cod_oseccion, int? cod_op_semana) async {
    return HTTPApi.httpGet(path,'/clases/semanahabilitada/','$email&$cod_oseccion&$cod_op_semana');
  }

  @override
  Future<ListaDocente_Model> getSolicitud(String? email,int? cod_oseccion,int? cod_op_semana) async {
    return HTTPApi.httpGet(path,'/clases/solicitudes/','$email&$cod_oseccion&$cod_op_semana');
  }

  @override
  Future<ListaDocente_Model> getAsistenciaClase(int? cod_oseccion, int? cod_asistencia_habilitado) async {
    return HTTPApi.httpGet(path,'/clases/asistencia/','$cod_oseccion&$cod_asistencia_habilitado');
  }

  @override
  Future<ListaDocente_Model> putSemanaActualizada(String? email, String? body) async {
    return HTTPApi.httpPut(path,'/clases/asistencia/','$email','$body');
  }

  @override
  Future<ListaDocente_Model> putAsistenciaCerrada(String? email, String? body) async {
    return HTTPApi.httpPut(path,'/clases/asistencia/cerrada/','$email','$body');
  }

  @override
  Future<ListaDocente_Model> postAsistenciaHabilitada(String body) async{
    return HTTPApi.httpPost(path,'/clases/asistencia/','$body');
  }
  
  

  //ASISTENCIA
  @override
  Future<ListaDocente_Model> getCursosAlumno(String? email) async {
    return HTTPApi.httpGet(path,'/asistencia/cursos/','$email');
  }
  
  @override
  Future<ListaDocente_Model> getAsistenciaHoy(String? email) async {
    return HTTPApi.httpGet(path,'/asistencia/hoy/','$email');
  }

  @override
  Future<ListaDocente_Model> getInformacionAsistencia(String? email,int? cod_oseccion) async {
    return HTTPApi.httpGet(path,'/asistencia/opciones/','$email&$cod_oseccion');
  }

  @override
  Future<ListaDocente_Model> postAsistencia(String body) async {
    return HTTPApi.httpPost(path,'/asistencia','$body');
  }
}