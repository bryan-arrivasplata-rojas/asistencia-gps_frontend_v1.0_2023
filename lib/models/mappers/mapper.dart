// ignore_for_file: non_constant_identifier_names

import 'package:flutter_application/models/common/common.dart';
import 'package:flutter_application/models/modelos/model.dart';

class UserMapper implements UsuarioMapper{
  @override
  fromMap_model(List<dynamic> json)  => ListaDocente_Model(
    response: json,
  );
}