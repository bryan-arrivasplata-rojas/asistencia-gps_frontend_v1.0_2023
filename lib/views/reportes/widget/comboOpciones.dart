// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unused_local_variable, unused_element

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_application/controller/controller.dart';
import 'package:flutter_application/models/modelos/model.dart';
import 'package:flutter_application/views/reportes/widget/listWidget.dart';
import 'package:flutter_application/views/widget/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComboOpciones extends StatefulWidget {
  const ComboOpciones(this.facultades, {super.key});
  // ignore: prefer_typing_uninitialized_variables
  final List facultades;
  @override
  State<ComboOpciones> createState() => _ComboOpcionesState();
}

class _ComboOpcionesState extends State<ComboOpciones> {
  var ivisible=false;
  void isVisible(bool val) {
    setState(() {
      ivisible=val;
    });
  }
  
  // ignore: prefer_typing_uninitialized_variables
  List<Widget> widgets =[

  ];
  //ComboBox
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
  String? selectedValue;
  String? selectedValue_facultad;
  String? selectedValue_curso;
  String? selectedValue_seccion;
  String? selectedValue_semana;
  String? selectedValue_solicitud;
  
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController textEditingController_facultad = TextEditingController();
  final TextEditingController textEditingController_curso = TextEditingController();
  final TextEditingController textEditingController_seccion = TextEditingController();
  final TextEditingController textEditingController_semana = TextEditingController();
  final TextEditingController textEditingController_solicitud = TextEditingController();

  //COMBOBOX
  late ListaDocente_Model usuariocurso;
  late ListaDocente_Model usuarioseccion;
  late ListaDocente_Model usuariosemana;
  late ListaDocente_Model usuariosolicitud;
  late ListaDocente_Model usuario;
  late ListaDocente_Model usuariosemanahabilitado;
  late ListaDocente_Model usuariosemanahabilitadoupdate;
  late ListaDocente_Model asistenciaclose;
  bool data_cursos = false;
  List cursos = [];
  bool data_secciones = false;
  List secciones = [];
  bool data_semanas = false;
  List semanas = [];
  bool data_solicitudes = false;
  List solicitudes = [];
  bool data_usuario = false;
  List usuarios = [];
  bool data_configuracion = false;
  List configuracion = [];
  
  
  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    double largo = MediaQuery.of(context).size.height;
    
    return SizedBox(
      //width: ancho,
      child: Material(
        child: Container(
          //padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          //width: ancho,
          //height: largo*0.01,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children:[
              Container(
                margin:EdgeInsets.fromLTRB(0.01*ancho,0.01*largo, 0.01*ancho, 5),
                width: ancho,
                child:DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Seleccionar una Facultad',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: widget.facultades
                        .map((item) => DropdownMenuItem<String>(
                              value: item['cod_facultad'].toString(),
                              child: Text(
                                '${item['abreviatura']}: ${item['descripcion']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue_facultad,
                    onChanged: (value){
                      setState(() {
                        selectedValue_facultad = value as String; 
                        llenarCursos(value).then((data) {
                          if(usuariocurso.response.isNotEmpty){
                            if(!usuariocurso.response.contains('error')){
                              setState(() {
                                data_cursos = data; 
                              });
                              if (data == false) {
                                null;
                              } else {
                                cursos.clear();
                                secciones.clear();
                                semanas.clear();
                                solicitudes.clear();
                                selectedValue_curso = null;
                                selectedValue_seccion = null;
                                selectedValue_semana = null;
                                selectedValue_solicitud = null;
                                isVisible(false);
                                extrarDistinct(usuariocurso.response,cursos,'cod_curso','descripcion',null,null);
                              }
                            }else{
                              alert(context, 'Error', 'Intente en unos minutos nuevamente');
                            }
                          }else{
                            alert(context, 'Error', 'Intente en unos minutos nuevamente');
                          }
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    iconEnabledColor: const Color.fromARGB(255, 255, 255, 255),
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 50,
                    buttonWidth: 160,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff800404),
                    ),
                    buttonElevation: 2,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownWidth: ancho,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xff800404),
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(-20, 0),
                    searchController: textEditingController_facultad,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        controller: textEditingController_facultad,
                        style: const TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Buscar una facultad ...',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value.toString().contains(searchValue));
                    },
                    //This to clear the search value when you close the menu
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        textEditingController.clear();
                      }
                    },
                  ),
                ),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(0.01*ancho, 0, 0.01*ancho, 5),
                width: ancho,
                child:DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Seleccionar un Curso',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: cursos
                        .map((item) => DropdownMenuItem<String>(
                              value: item['cod_curso'].toString(),
                              child: Text(
                                '${item['cod_curso']}: ${item['descripcion']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue_curso,
                    onChanged: (value) {
                      setState(() {
                        selectedValue_curso = value as String;
                        llenarSecciones(selectedValue_facultad,value).then((data) {           
                          if(usuarioseccion.response.isNotEmpty){
                            if(!usuarioseccion.response.contains('error')){
                              setState(() {
                                data_secciones = data; 
                              });
                              if (data == false) {
                                null;
                              } else {
                                secciones.clear();
                                semanas.clear();
                                solicitudes.clear();
                                selectedValue_seccion = null;
                                selectedValue_semana = null;
                                selectedValue_solicitud = null;
                                isVisible(false);
                                extrarDistinct(usuarioseccion.response,secciones,'cod_oseccion','cod_seccion','descripcion','referencia');
                              }
                            }else{
                              alert(context, 'Error', 'Intente en unos minutos nuevamente');
                            }
                          }else{
                            alert(context, 'Error', 'Intente en unos minutos nuevamente');
                          }
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    iconEnabledColor: const Color.fromARGB(255, 255, 255, 255),
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 50,
                    buttonWidth: 160,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff800404),
                    ),
                    buttonElevation: 2,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownWidth: ancho,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xff800404),
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(-20, 0),
                    searchController: textEditingController_curso,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        controller: textEditingController_curso,
                        style: const TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Buscar un curso ...',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value.toString().contains(searchValue));
                    },
                    //This to clear the search value when you close the menu
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        textEditingController.clear();
                      }
                    },
                  ),
                ),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(0.01*ancho, 0, 0.01*ancho, 5),
                width: ancho,
                child:DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Seleccionar una Sección',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: secciones
                        .map((item) => DropdownMenuItem<String>(
                              value: item['cod_oseccion'].toString(),
                              child: Text(
                                'Sección ${item['cod_seccion']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue_seccion,
                    onChanged: (value) {
                      setState(() {
                        selectedValue_seccion = value as String;
                        llenarSemanas().then((data) {
                          if(usuariosemana.response.isNotEmpty){
                            if(!usuariosemana.response.contains('error')){
                              setState(() {
                                data_semanas = data; 
                              });
                              if (data == false) {
                                null;
                              } else {
                                semanas.clear();
                                solicitudes.clear();
                                selectedValue_semana = null;
                                selectedValue_solicitud = null;
                                isVisible(false);
                                extrarDistinct(usuariosemana.response,semanas,'cod_op_semana','num_semana',null,null);
                              }
                            }else{
                              alert(context, 'Error', 'Intente en unos minutos nuevamente');
                            }
                          }else{
                            alert(context, 'Error', 'Intente en unos minutos nuevamente');
                          }    
                          
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    iconEnabledColor: const Color.fromARGB(255, 255, 255, 255),
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 50,
                    buttonWidth: 160,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff800404),
                    ),
                    buttonElevation: 2,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownWidth: ancho,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xff800404),
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(-20, 0),
                    searchController: textEditingController_seccion,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        controller: textEditingController_seccion,
                        style: const TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Buscar una sección ...',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value.toString().contains(searchValue));
                    },
                    //This to clear the search value when you close the menu
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        textEditingController.clear();
                      }
                    },
                  ),
                ),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(0.01*ancho, 0, 0.01*ancho, 5),
                width: ancho,
                child:DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Seleccionar una Semana',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                        ),
                      ],
                    ),
                    items: semanas.map(
                      (item) => DropdownMenuItem<String>(
                      value: item['cod_op_semana'].toString(),
                      child: Text(
                        '${item['num_semana']}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      )
                    ).toList(),
                    value: selectedValue_semana,
                    onChanged: (value) {
                      setState(() {
                        selectedValue_semana = value as String;
                        llenarSolicitud(selectedValue_seccion,value).then((data) {
                          if(usuariosolicitud.response.isNotEmpty){
                            if(!usuariosolicitud.response.contains('error')){
                              setState(() {
                                data_solicitudes= data; 
                              });
                              if (data == false) {
                                null;
                              } else {
                                solicitudes.clear();
                                selectedValue_solicitud = null;
                                isVisible(false);
                                extrarSolicitud(usuariosolicitud.response,solicitudes,'cod_asistencia_habilitado','fecha_created','descripcion');
                              }
                            }else{
                              alert(context, 'Error', 'Intente en unos minutos nuevamente');
                            }
                          }else{
                            alert(context, 'Error', 'Intente en unos minutos nuevamente');
                          }
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    iconEnabledColor: const Color.fromARGB(255, 255, 255, 255),
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 50,
                    buttonWidth: 160,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff800404),
                    ),
                    buttonElevation: 2,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownWidth: ancho,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xff800404),
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(-20, 0),
                    searchController: textEditingController_semana,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        controller: textEditingController_semana,
                        style: const TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Buscar una semana ...',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value.toString().contains(searchValue));
                    },
                    //This to clear the search value when you close the menu
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        textEditingController.clear();
                      }
                    },
                  ),
                ),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(0.01*ancho, 0, 0.01*ancho, 5),
                width: ancho,
                child:DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Seleccionar una Solicitud',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                        ),
                      ],
                    ),
                    items: solicitudes.map(
                      (item) => DropdownMenuItem<String>(
                      value: item['cod_asistencia_habilitado'].toString(),
                      child: Text(
                        item['descripcion'].toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      )
                    ).toList(),
                    value: selectedValue_solicitud,
                    onChanged: (value) {
                      setState(() {
                        selectedValue_solicitud = value as String;
                        llenarUsuarios(selectedValue_seccion,value).then((data) {
                          if(usuario.response.isNotEmpty){
                            if(!usuario.response.contains('error')){
                              setState(() {
                                //data_solicitudes = data; 
                              });
                              if (data == false) {
                                null;
                              } else {
                                usuarios.clear();
                                //selectedValue_seccion = null;
                                //selectedValue_semana = null;
                                //solicitudes.clear();usuarios
                                isVisible(true);
                                extrarUsuarios(usuario.response,usuarios,'id','codigo','nombre_completo','fecha_created_alumno','distancia','email','distancia_maxima','tiempo_cerrar_num_solicitud','fecha_created');
                              }
                            }else{
                              alert(context, 'Error', 'Intente en unos minutos nuevamente');
                            }
                          }else{
                            alert(context, 'Error', 'Intente en unos minutos nuevamente');
                          }
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    iconEnabledColor: const Color.fromARGB(255, 255, 255, 255),
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 50,
                    buttonWidth: 160,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff800404),
                    ),
                    buttonElevation: 2,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownWidth: ancho,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xff800404),
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(-20, 0),
                    searchController: textEditingController_solicitud,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        controller: textEditingController_solicitud,
                        style: const TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Buscar una solicitud ...',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 12,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value.toString().contains(searchValue));
                    },
                    //This to clear the search value when you close the menu
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        textEditingController.clear();
                      }
                    },
                  ),
                ),
              ),
              Visibility(
                visible: ivisible,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child:Container(
                  height: largo*0.4,
                  child:ListWidget(usuarios),
                ),
              ),
              Visibility(
                visible: ivisible,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child:Container(
                  padding:EdgeInsets.fromLTRB(0, 6*largo/ancho, 0, 0),
                  //margin: EdgeInsets.fromLTRB(40 * largo/ancho, 20 * largo/ancho, 40 * largo/ancho, 0),
                  width: ancho,
                  //height: 0.06 * largo,
                  child:ElevatedButton(
                    onPressed: () async {
                      //_createPDF();
                    },
                    style:ElevatedButton.styleFrom( //<-- SEE HERE
                      backgroundColor: const Color(0xff800404),
                      shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(0)
                      ),
                    ),
                    child:const Text(
                        'Imprimir',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  extrarDistinct(List <dynamic> data,List arreglo,String value,String? value_1,String? value_2,String? value_3){
    if(data.isNotEmpty){
      for(var x in data ){
        if(value_1!=null){
          if(value_2!=null){
            if(value_3!=null){
              arreglo.add({value:x[value],value_1:x[value_1],value_2:x[value_2],value_3:x[value_3]});
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
  extrarSolicitud(List <dynamic> data,List arreglo,String value,String? fecha_created,String? value_2) {
    if(data.isNotEmpty){
      for(var x in data ){ 
        if(fecha_created!=null){
          String descripcion = x[fecha_created];
          if(value_2!=null){
            arreglo.add({value:x[value],'descripcion':descripcion,'descripcion_semana':x[value_2]});
          }else{
            arreglo.add({value:x[value],'descripcion':descripcion});
          }
        }else{
          arreglo.add({value:x[value]}); 
        }
      }
    }
  }
  extrarUsuarios(List <dynamic> data,List arreglo,String value,String value_1,String value_2,String value_3,String value_4,String value_5,String value_6,String value_7,String value_8) {
    if(data.isNotEmpty){
      for(var x in data ){ 
        String descripcion = '${x[value_1]}: ${x[value_2]}';
        arreglo.add({value:x[value],value_1:x[value_1],value_2:x[value_2],'fecha_created_alumno':x[value_3],value_4:x[value_4],value_5:x[value_5],value_6:x[value_6],value_7:x[value_7],'fecha_created_docente':x[value_8],'descripcion':descripcion});
      }
    }
  }
  Future llenarCursos(value) async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    UsuarioController usuarioController = UsuarioController();
    usuariocurso = await usuarioController.getCursos(prefs.getString('email'),int.parse(value));
    return true;
    //debugPrint(usuario.response.toString());
  }
  Future llenarSecciones(value_1,value) async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    UsuarioController usuarioController = UsuarioController();
    usuarioseccion= await usuarioController.getSecciones(prefs.getString('email'),int.parse(value_1),value.toString());
    //debugPrint(usuarioseccion.response.toString());
    return true;
  }
  Future llenarSemanas() async {
    UsuarioController usuarioController = UsuarioController();
    usuariosemana= await usuarioController.getSemanas();
    return true;
  }
  Future llenarSolicitud(value,value_1) async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    UsuarioController usuarioController = UsuarioController();
    usuariosolicitud= await usuarioController.getSolicitud(prefs.getString('email'),int.parse(value),int.parse(value_1));
    return true;
  }
  Future llenarUsuarios(value,value_1) async {
    UsuarioController usuarioController = UsuarioController();
    usuario = await usuarioController.getAsistenciaClase(int.parse(value),int.parse(value_1));
    //debugPrint(usuario.response.toString());
    return true;
  }
  @override
  void initState() {
    super.initState();
    cursos.clear();
    secciones.clear();
    semanas.clear();
    usuarios.clear();
    //cerrarAsistenciaHabilitada();
  }
}


