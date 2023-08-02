// ignore_for_file: unused_local_variable, unnecessary_new, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/mappers/mapper.dart';
import 'package:flutter_application/models/modelos/model.dart';
import 'package:http/http.dart' as http;
class HTTPApi {
  static final UserMapper _loginMapper = UserMapper();
  static Future<ListaDocente_Model> httpGet(String? path,String? enlace, String? data) async {
    try{
      if(data == null){
        http.Response response = await http.get(Uri.parse('$path$enlace')).timeout(const Duration(seconds: 2));
        final valor = jsonDecode(response.body) as List<dynamic>;
        return _loginMapper.fromMap_model (valor);
      }else{
        http.Response response = await http.get(Uri.parse('$path$enlace$data')).timeout(const Duration(seconds: 2));
        final valor = jsonDecode(response.body) as List<dynamic>;
        return _loginMapper.fromMap_model (valor);
      }
    }catch(_){
      List<dynamic> error = ['error'];
      return _loginMapper.fromMap_model (error);//error
    }
  }

  static Future<ListaDocente_Model> httpPut(String? path,String? enlace, String? data,String? body) async {
    try{
      if(data == null){
        http.Response response = await http.put(
          Uri.parse('$path$enlace'),
          body:body,
          headers: { "Content-Type" : "application/json"}
        ).timeout(const Duration(seconds: 2));
        //debugPrint(response.body.toString());
        final valor = jsonDecode(response.body) as List<dynamic>;
        return _loginMapper.fromMap_model (valor);
      }else{
        http.Response response = await http.put(
        Uri.parse('$path$enlace$data'),
        body:body,
        headers: { "Content-Type" : "application/json"}).timeout(const Duration(seconds: 2));
        final valor = jsonDecode(response.body) as Map<String,dynamic>;
        return _loginMapper.fromMap_model ([{'response':valor['changedRows']}]);
      }
    }catch(_){
      List<dynamic> error = ['error'];
      return _loginMapper.fromMap_model (error);//error
    }
  }

  static Future<ListaDocente_Model> httpPost(String? path,String? enlace, String? body) async {
    try{
      http.Response response = await http.post(
        Uri.parse('$path$enlace'),
        body:body,
        headers: { "Content-Type" : "application/json"}
      ).timeout(const Duration(seconds: 2));
      //final valor = jsonDecode(response.body) as Map<String, dynamic>;
      final valor = (jsonDecode(response.body) as Map<String,dynamic>);
      return _loginMapper.fromMap_model ([{'response':valor['affectedRows'],'insertId':valor['affectedRows'],'valor':valor}]);
    }catch(_){
      List<dynamic> error = ['error'];
      return _loginMapper.fromMap_model (error);//error
    }
  }
}