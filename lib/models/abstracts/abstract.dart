// ignore_for_file: non_constant_identifier_names

import 'package:flutter_application/models/modelos/model.dart';

abstract class UsuarioGateway{
  Future<ListaDocente_Model> getUsuario (String email);
  Future<ListaDocente_Model> getFacultad (String email);
  Future<ListaDocente_Model> getAula (int cod_facultad);
  Future<ListaDocente_Model> getCursos (String email,int cod_facultad);
  Future<ListaDocente_Model> getSecciones (String email,int cod_facultad,String cod_curso);
  Future<ListaDocente_Model> getSemanas ();
  Future<ListaDocente_Model> getSolicitud (String email,int cod_oseccion,int cod_op_semana);
  Future<ListaDocente_Model> getSemanaHabilitada (String email,int cod_oseccion,int cod_op_semana);
  Future<ListaDocente_Model> putSemanaActualizada (String email,String body);
  Future<ListaDocente_Model> putAsistenciaCerrada (String email,String body);
  Future<ListaDocente_Model> postAsistenciaHabilitada (String body);
  Future<ListaDocente_Model> getPerfil (String email);
  Future<ListaDocente_Model> putPerfil (String email,String body);
  Future<ListaDocente_Model> getAsistenciaClase (int cod_oseccion,int cod_asistencia_habilitado);
  Future<ListaDocente_Model> getCursosAlumno (String email);
  Future<ListaDocente_Model> getInformacionAsistencia (String email,int cod_oseccion);
  Future<ListaDocente_Model> getAsistenciaHoy (String email);
  Future<ListaDocente_Model> postAsistencia (String body);
}