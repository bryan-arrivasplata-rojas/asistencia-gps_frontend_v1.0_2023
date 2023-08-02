// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_application/controller/controller.dart';
import 'package:flutter_application/models/modelos/model.dart';
import 'package:flutter_application/views/widget/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:intl/intl.dart';

class ComboOpciones extends StatefulWidget {
  const ComboOpciones(this.facultades, {super.key});
  // ignore: prefer_typing_uninitialized_variables
  final List facultades;
  @override
  State<ComboOpciones> createState() => _ComboOpcionesState();
}
enum Place { notlimite, limit}
class _ComboOpcionesState extends State<ComboOpciones> {
  var ivisible=false;
  var ovisible=false;
  
  void isVisible(bool val) {
    setState(() {
      ivisible=val;
    });
  }
  void isVisibleCrear(bool val) {
    setState(() {
      if(val){
        isVisible_button_crear = true;
        isVisible_button_modificar = false;
      }else{
        isVisible_button_crear = false;
        isVisible_button_modificar = true;
      }
    });
  }
  void actualizarConfiguracion() {
    llenarConfiguracion(selectedValue_seccion,selectedValue_semana).then((data) {           
      setState(() {
        data_configuracion= data;
      });
      if (data == false) {
        null;
      } else {
        //configuracion.clear();
        configuracion.clear();
        extrarConfiguracion(usuariosemanahabilitado.response,configuracion,'cod_asistencia_habilitado','distancia_maxima','tiempo_cerrar_num_solicitud','fecha_cierre','descripcion','habilitado','cod_aula');
        //isVisible(true);
      }
    });
    /*llenarConfiguracion(selectedValue_seccion,value).then((data) {
      if(usuariosemanahabilitado.response.isNotEmpty){
        if(!usuariosemanahabilitado.response.contains('error')){
          setState(() {
            data_configuracion= data; 
          });
          if (data == false) {
            null;
          } else {
            configuracion.clear();
            extrarConfiguracion(usuariosemanahabilitado.response,configuracion,'cod_asistencia_habilitado','distancia_maxima','tiempo_cerrar_num_solicitud','fecha_cierre','descripcion','habilitado','cod_aula');
            isVisible(true);
          }
        }else{
          alert(context, 'Error', 'Intente en unos minutos nuevamente');
        }
      }else{
        selectedValue_aula=null;
        alert(context, 'Información', 'Crear la primera asistencia de la semana');//ACA
        handleSelection_metro(Place.notlimite);
        handleSelection_tiempo(Place.notlimite);
        textEditingController_distancia.text = '';
        textEditingController_tiempo.text = '';
        //aulas.clear();
        //extrarConfiguracion(usuarioaula.response,aulas,'cod_aula','latitud','longitud','referencia','descripcion',null,null);
        //selectedValue_aula=null;
        fecha_cierre = "Aun no hay registro de asistencia";
        isVisible(true);
        isVisibleCrear(true);
      }
    });*/
  }
  
  //RadioButtons
  Place? _place_metro = Place.notlimite;
  Place? _place_tiempo = Place.notlimite;
  bool _homeFieldVisible_metro = false;
  bool _homeFieldVisible_tiempo = false;
  void handleSelection_metro(Place? value) {
    setState(() {
      _place_metro = value;
      _homeFieldVisible_metro = value == Place.limit;
    });
  }
  void handleSelection_tiempo(Place? value) {
    setState(() {
      _place_tiempo = value;
      _homeFieldVisible_tiempo = value == Place.limit;
    });
  }
  // ignore: prefer_typing_uninitialized_variables
  
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
  String? selectedValue_aula;
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController textEditingController_facultad = TextEditingController();
  final TextEditingController textEditingController_curso = TextEditingController();
  final TextEditingController textEditingController_seccion = TextEditingController();
  final TextEditingController textEditingController_semana = TextEditingController();
  final TextEditingController textEditingController_aula = TextEditingController();
  
  //COMBOBOX
  late ListaDocente_Model usuariocurso;
  late ListaDocente_Model usuarioseccion;
  late ListaDocente_Model usuariosemana;
  late ListaDocente_Model usuarioaula;
  late ListaDocente_Model usuariosemanahabilitado;
  late ListaDocente_Model usuariosemanahabilitadoupdate;
  late ListaDocente_Model asistenciaclose;
  bool data_cursos = false;
  List cursos = [];
  bool data_secciones = false;
  List secciones = [];
  bool data_semanas = false;
  List semanas = [];
  bool data_aulas = false;
  List aulas = [];
  bool data_configuracion = false;
  List configuracion = [];
  String fecha_cierre = 'error';

  final TextEditingController textEditingController_distancia = TextEditingController();
  final TextEditingController textEditingController_tiempo = TextEditingController();
  bool isVisible_button_crear = false;
  bool isVisible_button_modificar = false;

  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    double largo = MediaQuery.of(context).size.height;
    //debugPrint(widget.facultades.toString());
    return Column(
      mainAxisSize: MainAxisSize.max,
      children:[
        Container(
          padding:EdgeInsets.fromLTRB(0, 0.02*largo, 0, 0),
          width: ancho,
          child: Text(
            'Asistencia',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 10 *largo/ancho,
              color: const Color.fromARGB(255, 0, 0, 0),
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
                          selectedValue_curso = null;
                          selectedValue_seccion = null;
                          selectedValue_semana = null;
                          isVisible(false);
                          extrarDistinct(usuariocurso.response,cursos,'cod_curso','descripcion',null,null,null);
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
                          selectedValue_seccion = null;
                          selectedValue_semana = null;
                          isVisible(false);
                          extrarDistinct(usuarioseccion.response,secciones,'cod_oseccion','cod_seccion','descripcion','referencia','clase');
                        }
                      }else{
                        alert(context, 'Error', 'Intente en unos minutos nuevamente');
                      }
                    } else{
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
                          selectedValue_semana = null;
                          isVisible(false);
                          extrarDistinct(usuariosemana.response,semanas,'cod_op_semana','num_semana',null,null,null);
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
                  if(selectedValue_seccion!=null){
                    selectedValue_semana = value as String;
                    llenarAula().then((data) {
                      if(usuarioaula.response.isNotEmpty){
                        if(!usuarioaula.response.contains('error')){
                          setState(() {
                            data_aulas= data; 
                          });
                          if (data == false) {
                            null;
                          } else {
                            aulas.clear();
                            extrarAula(usuarioaula.response,aulas,'cod_aula','latitud','longitud','referencia','descripcion');
                            //isVisible(true);
                          }
                        }else{
                          selectedValue_aula=null;
                        }
                      }
                    });
                    llenarConfiguracion(selectedValue_seccion,value).then((data) {
                      if(usuariosemanahabilitado.response.isNotEmpty){
                        if(!usuariosemanahabilitado.response.contains('error')){
                          setState(() {
                            data_configuracion= data; 
                          });
                          if (data == false) {
                            null;
                          } else {
                            configuracion.clear();
                            extrarConfiguracion(usuariosemanahabilitado.response,configuracion,'cod_asistencia_habilitado','distancia_maxima','tiempo_cerrar_num_solicitud','fecha_cierre','descripcion','habilitado','cod_aula');
                            isVisible(true);
                          }
                        }else{
                          alert(context, 'Error', 'Intente en unos minutos nuevamente');
                        }
                      }else{
                        selectedValue_aula=null;
                        alert(context, 'Información', 'Crear la primera asistencia de la semana');//ACA
                        handleSelection_metro(Place.notlimite);
                        handleSelection_tiempo(Place.notlimite);
                        textEditingController_distancia.text = '';
                        textEditingController_tiempo.text = '';
                        //aulas.clear();
                        //extrarConfiguracion(usuarioaula.response,aulas,'cod_aula','latitud','longitud','referencia','descripcion',null,null);
                        //selectedValue_aula=null;
                        fecha_cierre = "Aun no hay registro de asistencia";
                        isVisible(true);
                        isVisibleCrear(true);
                      }
                    });
                    
                    //selectedValue_aula = null;
                    //isVisible(false);
                    //alerta(context,'Debe seleccionar primero una sección',CoolAlertType.warning,'Seleccionar datos');
                  }
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
        Visibility(
          visible: ivisible,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child:Column(
            children: [
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
                            'Seleccionar el aula',
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
                    items: aulas
                        .map((item) => DropdownMenuItem<String>(
                              value: item['cod_aula'].toString(),
                              child: Text(
                                'Aula ${item['cod_aula']}: ${item['referencia']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue_aula,
                    onChanged: (value) {
                      setState(() {
                        selectedValue_aula = value as String;
                        llenarSemanas().then((data) {
                          if(usuarioaula.response.isNotEmpty){
                            if(!usuarioaula.response.contains('error')){
                              setState(() {
                                data_aulas = data; 
                              });
                              if (data == false) {
                                null;
                              } else {
                                //isVisible(false);
                                //extrarDistinct(usuariosemana.response,semanas,'cod_op_semana','num_semana',null,null,null);
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
                    searchController: textEditingController_aula,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        controller: textEditingController_aula,
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
                          hintText: 'Buscar el aula ...',
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:EdgeInsets.fromLTRB(0, 0.02*largo, 0, 0),
                    width: ancho,
                    child: Text(
                      'Distancia (mts)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 10 *largo/ancho,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    margin:EdgeInsets.fromLTRB(0.05 * ancho,0 , 0.05* ancho, 0),
                    //padding:EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: ancho,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child:SizedBox(
                            child:RadioListTile(
                              title: const Text(
                                'Sin límite',
                                style:TextStyle(
                                  color:Color.fromARGB(255, 0, 0, 0),//Color(0xff800404)
                                  fontSize: 12,
                                ),
                              ),
                              value: Place.notlimite,
                              groupValue: _place_metro,
                              onChanged: handleSelection_metro,
                              activeColor: const Color(0xff800404),
                              
                            ),
                          ),
                        ),
                        Expanded(
                          child:SizedBox(
                            child:RadioListTile(
                              title: const Text('Límite',style:TextStyle(
                                  color:Color.fromARGB(255, 0, 0, 0),//Color(0xff800404)
                                  fontSize: 12,
                                ),),
                              value: Place.limit,
                              groupValue: _place_metro,
                              onChanged: handleSelection_metro,
                              activeColor: const Color(0xff800404),
                            ),
                          ),
                        ),
                        if (_homeFieldVisible_metro)
                        Container(
                          width: 40*largo/ancho,
                          margin:EdgeInsets.fromLTRB(0, 0, 0.02*ancho, 0),
                          child:TextField(
                            decoration:const InputDecoration(
                              hintText: 'mtrs.',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                ),
                              ),
                              counter: Offstage(),
                            ),
                            controller: textEditingController_distancia,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:EdgeInsets.fromLTRB(0, 0.02*largo, 0, 0),
                    width: ancho,
                    child: Text(
                      'Tiempo (min)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 10 *largo/ancho,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    margin:EdgeInsets.fromLTRB(0.05 * ancho,0 , 0.05* ancho, 0),
                    //padding:EdgeInsets.fromLTRB(0, 0.02*largo, 0, 0),
                    width: ancho,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child:SizedBox(
                            child:RadioListTile(
                              title: const Text(
                                'Sin límite',
                                style:TextStyle(
                                  color:Color.fromARGB(255, 0, 0, 0),//Color(0xff800404)
                                  fontSize: 12,
                                ),
                              ),
                              value: Place.notlimite,
                              groupValue: _place_tiempo,
                              onChanged: handleSelection_tiempo,
                              activeColor: const Color(0xff800404),
                              
                            ),
                          ),
                        ),
                        Expanded(
                          child:SizedBox(
                            child:RadioListTile(
                              title: const Text('Límite',style:TextStyle(
                                  color:Color.fromARGB(255, 0, 0, 0),//Color(0xff800404)
                                  fontSize: 12,
                                ),),
                              value: Place.limit,
                              groupValue: _place_tiempo,
                              onChanged: handleSelection_tiempo,
                              activeColor: const Color(0xff800404),
                              
                            ),
                          ),
                        ),
                        if (_homeFieldVisible_tiempo)
                        Container(
                          width: 40*largo/ancho,
                          margin:EdgeInsets.fromLTRB(0, 0, 0.02*ancho, 0),
                          child:TextField(
                            decoration: const InputDecoration(
                              hintText: 'min.',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                ),
                              ),
                              counter: Offstage(),
                            ),
                            keyboardType: TextInputType.number,
                            controller:textEditingController_tiempo,
                            textAlign: TextAlign.center,
                            maxLength: 4,
                            
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                //margin:EdgeInsets.fromLTRB(0.05 * ancho,0 , 0.05* ancho, 0),
                //padding:EdgeInsets.fromLTRB(0, 0.02*largo, 0, 0),
                width: ancho,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: isVisible_button_crear,
                      maintainSize: false,
                      maintainAnimation: false,
                      maintainState: false,
                      child:Container(
                        margin:const EdgeInsets.fromLTRB(0,0,5, 0),
                        child:ElevatedButton(
                          onPressed: ()  {
                            if(selectedValue_aula!=null){
                              int valor_tiempo;
                              String valor_distancia;
                              if(_place_metro==Place.notlimite){
                                valor_distancia='0';
                              }else{
                                valor_distancia = textEditingController_distancia.text;
                              }
                              if(_place_tiempo==Place.notlimite){
                                valor_tiempo=0;
                              }else{
                                valor_tiempo = int.parse(textEditingController_tiempo.text);
                              }
                              postAsistenciaHabilitada(int.parse(selectedValue_semana!),int.parse(selectedValue_seccion!),int.parse(selectedValue_aula!),valor_distancia.toString(),valor_tiempo);
                            }else{
                              alert(context,'Información','Debe seleccionar un aula para continuar');
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
                              'Crear Asistencia',
                              textAlign: TextAlign.center,
                              style:TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isVisible_button_modificar,
                      maintainSize: false,
                      maintainAnimation: false,
                      maintainState: false,
                      child:Container(
                        margin:const EdgeInsets.fromLTRB(0,0,5, 0),
                        child:ElevatedButton(
                          onPressed: ()  {
                            int valor_tiempo;
                            double valor_distancia;
                            if(configuracion.isNotEmpty){
                              if(_place_metro==Place.notlimite){
                                valor_distancia=0.0;
                              }else{
                                valor_distancia = double.parse(textEditingController_distancia.text);
                              }
                              if(_place_tiempo==Place.notlimite){
                                valor_tiempo=0;
                              }else{
                                valor_tiempo = int.parse(textEditingController_tiempo.text);
                              }
                              updateAsistenciaHabilitada(configuracion[0]['cod_asistencia_habilitado'],int.parse(selectedValue_seccion??'0'),selectedValue_aula,valor_distancia,valor_tiempo);
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
                              'Modificar asistencia',
                              textAlign: TextAlign.center,
                              style:TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isVisible_button_modificar,
                      maintainSize: false,
                      maintainAnimation: false,
                      maintainState: false,
                      child:Container(
                        margin:const EdgeInsets.fromLTRB(5,0,0, 0),
                        child:ElevatedButton(
                          onPressed: ()  {
                            updateAsistenciaCerrada(configuracion[0]['cod_asistencia_habilitado'],1);
                          },
                          style:ElevatedButton.styleFrom( //<-- SEE HERE
                            backgroundColor: const Color(0xff800404),
                            shape: RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(50 * largo/ancho,
                              )
                            ),
                          ),
                          child:const Text(
                              'Cerrar asistencia',
                              textAlign: TextAlign.center,
                              style:TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Spacer(),
              Container(
                margin:const EdgeInsets.fromLTRB(0,5,0,0),
                child:Text(
                  'Fecha de Cierre: $fecha_cierre',
                  textAlign: TextAlign.center,
                  style:const TextStyle(fontSize: 15.0),
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
  extrarDistinct(List <dynamic> data,List arreglo,String value,String? value_1,String? value_2,String? value_3,String? value_4){
    //debugPrint(data.toString());
    for(var x in data ){ 
      if (arreglo.contains(x[value].toString())){
        null;
      }else{
        if(value_1!=null){
          if(value_2!=null){
            if(value_3!=null){
              if(value_4!=null){
                arreglo.add({value:x[value],value_1:x[value_1],value_2:x[value_2],value_3:x[value_3],value_4:x[value_4]});
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
    //debugPrint(arreglo.toString());
  }
  extrarAula(List <dynamic> data,List arreglo,String value,String? value_1,String? value_2,String? value_3,String? value_4){
    for(var x in data ){
      if (arreglo.contains(x[value].toString())){
        null;
      }else{
        arreglo.add({value:x[value],value_1:x[value_1],value_2:x[value_2],value_3:x[value_3],value_4:x[value_4]});
      }
    }
  }
  extrarConfiguracion(List <dynamic> data,List arreglo,String value,String? value_1,String? value_2,String? value_3,String? value_4,String? value_5,String? value_6){
    for(var x in data ){
      if (arreglo.contains(x[value].toString())){
        null;
      }else{
        arreglo.add({value:x[value],value_1:x[value_1],value_2:x[value_2],value_3:x[value_3],value_4:x[value_4],value_5:x[value_5],value_6:x[value_6]});
      }
    }
    //tz.initializeTimeZones();
    if(configuracion.isNotEmpty){
      /*fecha_cierre = DateFormat("dd/MM/yyyy hh:mm:ss").format(
                            tz.TZDateTime.from(
                              DateTime.parse(
                                configuracion[0]['fecha_cierre']??'2023/01/26 01:56:58'
                              ),
                              tz.getLocation('America/Bogota')
                            )
                          ).toString();*/
      fecha_cierre = configuracion[0]['fecha_cierre'].toString();
      selectedValue_aula=configuracion[0]['cod_aula'].toString();
    }else{
      fecha_cierre = 'No fue creado asistencia';
    }
    if (arreglo.isNotEmpty){
      //button_asistencia = 'Modificar Asistencia';
      if(arreglo[0]['habilitado'] == 0){
        //button_asistencia = 'Crear Asistencia';
        isVisible_button_modificar = true;
        isVisible_button_crear = false;
      }else{
        //button_asistencia = 'Crear Asistencia';
        if(semanas[0]['cod_op_semana'].toString()==selectedValue_semana){
          isVisible_button_crear = true;
        }else{
          isVisible_button_crear = false;
        }
        isVisible_button_modificar = false;
      }
      if(arreglo[0]['distancia_maxima'] != 0){
        _place_metro = Place.limit;
        _homeFieldVisible_metro = true;
        textEditingController_distancia.text = arreglo[0]['distancia_maxima'].toString();
      }else{
        _place_metro = Place.notlimite;
        _homeFieldVisible_metro = false;
      }
      if(arreglo[0]['tiempo_cerrar_num_solicitud']!= 0){
        _place_tiempo = Place.limit;
        _homeFieldVisible_tiempo = true;
        textEditingController_tiempo.text = arreglo[0]['tiempo_cerrar_num_solicitud'].toString();
      }else{
        _place_tiempo = Place.notlimite;
        _homeFieldVisible_tiempo = false;
      }
    }else{
      //button_asistencia = 'Crear Asistencia';
      isVisible_button_crear = true;
      isVisible_button_modificar = false;
      _place_metro = Place.notlimite;
      _homeFieldVisible_metro = false;
      _place_tiempo = Place.notlimite;
      _homeFieldVisible_tiempo = false;
    }
    //debugPrint(arreglo.toString());
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
  Future llenarConfiguracion(value_1,value) async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    UsuarioController usuarioController = UsuarioController();
    usuariosemanahabilitado= await usuarioController.getSemanaHabilitada(prefs.getString('email'),int.parse(value_1),int.parse(value));
    return true;
  }
  Future llenarAula()async{
    UsuarioController usuarioController = UsuarioController();
    usuarioaula = await usuarioController.getAula(int.parse(selectedValue_facultad ?? ""));
    return true;
  }
  Future updateAsistenciaHabilitada(int cod_asistencia_habilitado,int cod_oseccion,String? cod_aula,double distancia_maxima,int tiempo_cerrar_num_solicitud) async {
    //usuariosemanahabilitado= await usuarioController.getSemanaHabilitada(prefs.getString('email'),int.parse(value_1),int.parse(value));
    //debugPrint(usuariosemanahabilitado.response.toString());
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    UsuarioController usuarioController = UsuarioController();
    String body = jsonEncode({'cod_asistencia_habilitado':cod_asistencia_habilitado,'cod_oseccion':cod_oseccion,'cod_aula':cod_aula,'distancia_maxima':distancia_maxima,'tiempo_cerrar_num_solicitud':tiempo_cerrar_num_solicitud});
    //debugPrint(configuracion.toString());
    if(configuracion[0]['distancia_maxima'] != distancia_maxima || configuracion[0]['tiempo_cerrar_num_solicitud'] != tiempo_cerrar_num_solicitud || configuracion[0]['cod_aula'] != selectedValue_aula){
      usuariosemanahabilitadoupdate = await usuarioController.putSemanaActualizada(prefs.getString('email'), body);
      if(usuariosemanahabilitadoupdate.response.isNotEmpty){
        if(!usuariosemanahabilitadoupdate.response.contains('error')){
          if(usuariosemanahabilitadoupdate.response[0]['response']==1){
            configuracion[0]['distancia_maxima'] = distancia_maxima;
            configuracion[0]['tiempo_cerrar_num_solicitud'] = tiempo_cerrar_num_solicitud;
            actualizarConfiguracion();
            await alert(context,'Modificación','Los parámetros para la asistencia fueron actualizados con éxito');
          }else if(usuariosemanahabilitadoupdate.response[0]['response']==0){
            await alert(context,'Modificación','Ocurrio un error, por favor reiniciar la aplicación');
          }else{
            await alert(context,'Modificación','Se ha presentado un problema, por favor contactar a soporte técnico');
          }
        }else{
          alert(context, 'Error', 'Intente en unos minutos nuevamente');
        }
      }else{
        alert(context, 'Error', 'Intente en unos minutos nuevamente');
      }
      
    }else{
      //alerta(context,'Debe modificar algun valor para continuar',CoolAlertType.warning,'Error actualizar');
      await alert(context,'Error modificación','Debe modificar algun valor para continuar');
    }
    //debugPrint(body);
    //usuariosemanahabilitadoupdate = await usuarioController.putSemanaActualizada(prefs.getString('email'), body);
    return true;
  }
  
  Future updateAsistenciaCerrada(int cod_asistencia_habilitado,int habilitado) async {
    //usuariosemanahabilitado= await usuarioController.getSemanaHabilitada(prefs.getString('email'),int.parse(value_1),int.parse(value));
    //debugPrint(usuariosemanahabilitado.response.toString());
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    UsuarioController usuarioController = UsuarioController();
    String body = jsonEncode({'cod_asistencia_habilitado':cod_asistencia_habilitado,'cod_oseccion':int.parse(selectedValue_seccion ?? '0'),'habilitado':habilitado});
    asistenciaclose = await usuarioController.putAsistenciaCerrada(prefs.getString('email'), body);
    if(asistenciaclose.response.isNotEmpty){
      if(!asistenciaclose.response.contains('error')){
        //isVisibleCrear(true);
        //alerta(context,asistenciaclose.response[0]['response'].toString(),CoolAlertType.success,'Actualización');
        if(asistenciaclose.response[0]['response'] == 1){
          isVisibleCrear(true);
          await alert(context,'Modificación','El curso se ha cerrado con éxito');
        }else{
          await alert(context,'Modificación','Ocurrio un error, por favor reiniciar la aplicación');
        }
      }else{
        alert(context, 'Error', 'Intente en unos minutos nuevamente');
      }
    }else{
      alert(context, 'Error', 'Intente en unos minutos nuevamente');
    }
    return true;
  }
  Future postAsistenciaHabilitada(int cod_op_semana,int cod_oseccion,int cod_aula,String distancia_maxima,int tiempo_cerrar_num_solicitud) async {
    //usuariosemanahabilitado= await usuarioController.getSemanaHabilitada(prefs.getString('email'),int.parse(value_1),int.parse(value));
    //debugPrint(usuariosemanahabilitado.response.toString());
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    UsuarioController usuarioController = UsuarioController();
    String body = jsonEncode(
      {
        'cod_op_semana':cod_op_semana,
        'cod_oseccion':cod_oseccion,
        'cod_aula':cod_aula,
        'distancia_maxima':distancia_maxima,
        'tiempo_cerrar_num_solicitud':tiempo_cerrar_num_solicitud,
        'email':prefs.getString('email')
      });
    if(body.isNotEmpty){
      usuariosemanahabilitadoupdate = await usuarioController.postAsistenciaHabilitada(body);
      //debugPrint(usuariosemanahabilitadoupdate.response.toString());
      if(usuariosemanahabilitadoupdate.response.isNotEmpty){
        if(!usuariosemanahabilitadoupdate.response.contains('error')){
          if(usuariosemanahabilitadoupdate.response[0]['response'] == 1){
            actualizarConfiguracion();
            isVisibleCrear(false);
            //actualizarConfiguracion();
            await alert(context,'Insertar','Se ha habilitado con éxito la asistencia, por favor avisar a sus estudiantes');
          }else if(usuariosemanahabilitadoupdate.response[0]['response'] == 0){
            await alert(context,'Insertar','Ocurrio un error, por favor reiniciar la aplicación');
          }else{
            await alert(context,'Insertar',usuariosemanahabilitadoupdate.response[0]['valor']['response'].toString());//
          }
        }else{
          alert(context, 'Error', 'Intente en unos minutos nuevamente');
        }
      }else{
        alert(context, 'Error', 'Intente en unos minutos nuevamente');
      }
      
    }else{
      //alerta(context,'Contactar a soporte Tecnico',CoolAlertType.warning,'Error insertar');
      await alert(context,'Error','Contactar a soporte Técnico');
    }
    return true;
  }
  @override
  void initState() {
    super.initState();
    cursos.clear();
    secciones.clear();
    semanas.clear();
    configuracion.clear();
    //cerrarAsistenciaHabilitada();
  }
}
