// ignore_for_file: unused_field, non_constant_identifier_names, use_build_context_synchronously, unnecessary_null_comparison, unused_import, library_prefixes, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/controller/controller.dart';
import 'package:flutter_application/models/modelos/model.dart';
import 'package:flutter_application/views/asistencia/widget/listWidgetAsistencia.dart';
import 'package:flutter_application/views/widget/alert.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_application/views/asistencia/widget/opcionesMarcarAsistencia.dart';
class ComboOpcionesAsistencia extends StatefulWidget {
  final List cursos;
  final List asistencias;
  const ComboOpcionesAsistencia(this.cursos,this.asistencias,{super.key});
  
  @override
  State<ComboOpcionesAsistencia> createState() => _ComboOpcionesAsistenciaState();
}

bool isLocationServiceEnabled = false;
var locationMessage="";
late double latitud;
late double longitud;
double distancia_obtenida = 00.00;

class _ComboOpcionesAsistenciaState extends State<ComboOpcionesAsistencia> {
  final TextEditingController textEditingController_curso = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  String? selectedValue_curso;
  late ListaDocente_Model asistenciaopciones;
  late ListaDocente_Model usuarioasistencia;
  
  List asistenciaopcion = [];
  bool data_asistencia = false;
  bool ivisible = false;
  bool ovisible = false;
  bool lvisible = false;
  bool btnvisible = false;
  String distancia_maxima_recibida = "";
  String tiempo_maximo_cierre = "";
  void isVisible(bool val) {
    setState(() {
      if(val){
        ivisible=true;
        ovisible = false;
      }else{
        ivisible=false;
        ovisible = true;
      }
    });
  }
  void btnVisible(bool val){
    setState(() {
      btnvisible = val;
    });
  }
  

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
  Future<void> actualizardatos()async{
    llenarInformacionAsistencia(selectedValue_curso).then((data) { 
      setState(() {
        asistenciaopcion.clear();
        btnvisible = false;
        //debugPrint(asistenciaopciones.response.toString());
        if(asistenciaopciones.response.isNotEmpty){
          distancia_obtenida = 0.0;
          isVisible(true);
          if(asistenciaopciones.response[0]['habilitado']==0){
            //btnVisible(true);
            alert(context,'Información','Podra marcar asistencia cuando se empieze recolectar información de GPS');
            actualizarDistancia();
          }else{
            btnVisible(false);
          }
          extrarDistinct(asistenciaopciones.response,asistenciaopcion,'cod_oseccion','cod_asistencia_habilitado','distancia_maxima','tiempo_cerrar_num_solicitud','latitud','longitud','fecha_cierre','cod_op_semana','habilitado');
        }else{
          isVisible(false);
          btnVisible(false);
        }
      });    
      
    });
    
  }
  late ListaDocente_Model asistencia;
  List asistencias = [];
  double distanceInMeters = 0;
  Timer? _clockTimer;
  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    double largo = MediaQuery.of(context).size.height;
    asistencias = widget.asistencias;
    return RefreshIndicator(
      onRefresh: ()async{
        await llenarCursosAlumno().then((value) => {
          asistencias.clear(),
          extraerList(asistencia.response,asistencias, 'id','descripcion_facultad','cod_curso','descripcion_curso','cod_seccion','referencia','fecha_created'),
          actualizardatos(),
        });
      },
      child: Column(
        //mainAxisSize: MainAxisSize.max,
        children:[
          Container(
            padding:EdgeInsets.fromLTRB(0, 0.02*largo, 0, 0),
            width: ancho,
            child: Text(
              'Marcar Asistencia',
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
                items: widget.cursos
                    .map((item) => DropdownMenuItem<String>(
                          value: item['cod_oseccion'].toString(),
                          child: Text(
                            item['descripcion'].toString(),
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
                    //debugPrint(widget.cursos.toString());
                    //debugPrint(widget.cursos[0].toString());
                    llenarInformacionAsistencia(value).then((data) {
                      asistenciaopcion.clear();
                      cancel();
                      //debugPrint(asistenciaopciones.response.toString());
                      if(asistenciaopciones.response.isNotEmpty){
                        distancia_obtenida = 0.0;
                        isVisible(true);
                        if(asistenciaopciones.response[0]['habilitado']==0){
                          //btnVisible(true);
                          alert(context,'Información','Podra marcar asistencia cuando se empieze recolectar información de GPS');
                          actualizarDistancia();
                        }else{
                          btnVisible(false);
                        }
                        extrarDistinct(asistenciaopciones.response,asistenciaopcion,'cod_oseccion','cod_asistencia_habilitado','distancia_maxima','tiempo_cerrar_num_solicitud','latitud','longitud','fecha_cierre','cod_op_semana','habilitado');
                      }else{
                        isVisible(false);
                        btnVisible(false);
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
                    //textEditingController.clear();
                  }
                },
              ),
            ),
          ),
          Visibility(
            visible: ivisible,
            maintainSize: false,
            maintainAnimation: false,
            maintainState: false,
            child:Column(
              children: [
                Text('Distancia máxima: $distancia_maxima_recibida mtrs.'),
                Text('Fecha de cierre: $tiempo_maximo_cierre'),
                Column(
                  children: <Widget>[
                    Text(
                      'Distancia del aula',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12*largo/ancho,color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Container(
                          margin: EdgeInsets.fromLTRB(0.05*ancho, 0.01*largo, 0, 0.01*largo),
                          padding: EdgeInsets.all(20*largo/ancho),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff800404)
                          ),
                          child: Text(
                              distancia_obtenida.toStringAsFixed(2),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12*largo/ancho,color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        const Text('mts.'),
                        const Spacer(),
                      ],
                    )
                  ],
                ),
                Visibility(
                  visible: btnvisible,
                  maintainSize: false,
                  maintainAnimation: false,
                  maintainState: false,
                  child:Column(
                    children: [
                      SizedBox(
                        width: ancho*0.7,
                        child:ElevatedButton(
                          onPressed: ()async {
                            if(asistenciaopciones.response.isNotEmpty){
                              if(!asistenciaopciones.response.contains('error')){
                                //debugPrint(asistenciaopciones.response.toString()),
                                //debugPrint(distancia_obtenida.toString()),
                                if(asistenciaopciones.response[0]['habilitado']==0){
                                  if(asistenciaopciones.response[0]['distancia_maxima']==0){
                                    postAsistencia(asistenciaopciones.response[0]['cod_op_semana'],int.parse(selectedValue_curso!),asistenciaopciones.response[0]['cod_asistencia_habilitado'],distanceInMeters);
                                    setState(() {
                                      cancel();
                                    });
                                  }else if(distanceInMeters<=asistenciaopciones.response[0]['distancia_maxima']){
                                    //btnVisible(false),
                                    postAsistencia(asistenciaopciones.response[0]['cod_op_semana'],int.parse(selectedValue_curso!),asistenciaopciones.response[0]['cod_asistencia_habilitado'],distanceInMeters);
                                    setState(() {
                                      cancel();
                                    });
                                  }else if(distanceInMeters>asistenciaopciones.response[0]['distancia_maxima']){
                                    //alerta(context, 'Distancia mayor a la permitida', CoolAlertType.info, 'Distancia'),
                                    await alert(context,'Distancia','Distancia mayor a la permitida, acercarse más al salon de clases');
                                    //debugPrint('Distancia mayor a la permitida'),
                                    isVisible(true);
                                    btnVisible(true);
                                  }else{
                                    //alerta(context, 'Ya no esta habilitado la asistencia', CoolAlertType.info, 'Distancia'),
                                    await alert(context,'Error','Ya no esta habilitado la asistencia');
                                    //debugPrint('no se puede grabar'),
                                    isVisible(false);
                                    btnVisible(false);
                                  }
                                }else{
                                  //alerta(context, 'La clase ya no esta habilitada para recibir asistencia', CoolAlertType.info, 'Alerta')
                                  await alert(context,'Error','La clase ya no esta habilitada para recibir asistencia');
                                }
                              }else{
                                alert(context, 'Error', 'La asistencia ya no se encuentra habilitado / actualize para corraborar si no es ello espere unos minutos');
                              }
                            }else{
                              //alerta(context, 'Ya marcaste asistencia', CoolAlertType.info, 'Alerta')
                              await alert(context,'Error','Contactar a soporte Tecnico');
                            }
                          },
                          style:ElevatedButton.styleFrom( //<-- SEE HERE
                            backgroundColor: const Color(0xff800404),
                            shape: RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(5 * largo/ancho,
                              )
                            ),
                          ),
                          child:const Text(
                              'Marcar Asistencia',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: ovisible,
            maintainSize: false,
            maintainAnimation: false,
            maintainState: false,
            child:Container(
              margin: EdgeInsets.fromLTRB(0, 0.05*largo, 0, 0),
              child:const Center(
                child:Text('No hay asistencia o ya marcaste asistencia'),
              ),
            ),
          ),
          Container(
            margin:const EdgeInsets.fromLTRB(0,15,0, 5),
            width: ancho,
            child:const Center(
              child:Text(
                'Lista de cursos que marco asistencia hoy',
                //'Bienvenido: $tipo_descripcion',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: largo*0.4,
            child:ListWidgetAsistencia(asistencias),
          ),
        ],
      ),
    );
  }

  
  Future llenarInformacionAsistencia(value) async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    UsuarioController usuarioController = UsuarioController();
    asistenciaopciones = await usuarioController.getInformacionAsistencia(prefs.getString('email'),int.parse(value??'0'));
    //debugPrint(asistenciaopciones.response.toString());
    return true;
  }
  Future<Position> activarServicio() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  Future<void> verificarServicio()async{
    isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
    //return isLocationServiceEnabled;
  }
  Future<void> getCurrentLocation()async{
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitud = position.latitude;
    longitud = position.longitude;
  }
  extrarDistinct(List <dynamic> data,List arreglo,String value,String? value_1,String? value_2,String? value_3,String? value_4,String? value_5,String? value_6,String? value_7,String? value_8){
    arreglo.clear();
    for(var x in data ){ 
      if (arreglo.contains(x[value].toString())){
        null;
      }else{
        obtenerParametros(x[value_2],x[value_3],x[value_6]);
        arreglo.add({value:x[value],value_1:x[value_1],value_2:x[value_2],value_3:x[value_3],value_4:x[value_4],value_5:x[value_5],value_6:x[value_6],value_7:x[value_7],value_8:x[value_8]}); 
      }
    }
  }
  obtenerParametros(distancia,tiempo,opcional ){
    if(distancia==0){
      distancia_maxima_recibida = 'Sin límite';
    }else{
      distancia_maxima_recibida = distancia.toString();
    }
    if(tiempo==0){
      tiempo_maximo_cierre = 'Hasta que el profesor lo cierre';
    }else{
      //debugPrint(opcional);
      tiempo_maximo_cierre = opcional.toString();
    }
    
  }
  void actualizarDistancia()async{//aca
    Timer.periodic(const Duration(milliseconds: 200), (Timer t) async{
      _clockTimer = t;
      activarServicio().then((value) => {
        getCurrentLocation().then((value) async => {
          //debugPrint(asistenciaopciones.response.toString()),
          //debugPrint(locationMessage.toString()),
          if(asistenciaopciones.response.isNotEmpty){
            if(!asistenciaopciones.response.contains('error')){
              setState((){
                btnvisible = true;
                distanceInMeters = Geolocator.distanceBetween(asistenciaopciones.response[0]['latitud'], asistenciaopciones.response[0]['longitud'], latitud, longitud)/10;
                distancia_obtenida = distanceInMeters;
                //debugPrint(distancia_obtenida.toString());
              })
            }
          }
        })
      });
    });
  }
  void cancel(){
    _clockTimer?.cancel();
    _clockTimer=null;
  }
  Future postAsistencia(int cod_op_semana,int cod_oseccion,int cod_asistencia_habilitado,double distancia) async {
    //usuariosemanahabilitado= await usuarioController.getSemanaHabilitada(prefs.getString('email'),int.parse(value_1),int.parse(value));
    //debugPrint(usuariosemanahabilitado.response.toString());
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    UsuarioController usuarioController = UsuarioController();
    String body = jsonEncode({'cod_op_semana':cod_op_semana,'email':prefs.getString('email'),'cod_oseccion':cod_oseccion,'cod_asistencia_habilitado':cod_asistencia_habilitado,'distancia':distancia});
    if(body.isNotEmpty){
      usuarioasistencia = await usuarioController.postAsistencia(body);
      llenarCursosAlumno().then((value) async{
        if(asistencia.response.isNotEmpty){
          if(!asistencia.response.contains('error')){
            asistencias.clear();
            String data = usuarioasistencia.response[0]['valor']['response'].toString();
            if(data=='null'){
              await alert(context,'Asistencia','Su asistencia fue registrado con éxito');
              isVisible(false);
              btnVisible(false);
              extraerList(asistencia.response,asistencias, 'id','descripcion_facultad','cod_curso','descripcion_curso','cod_seccion','referencia','fecha_created');
              setState(() {
                asistencias=asistencias;
              });
            }else{
              await alert(context,'Asistencia',data);
            }
          }else{
            alert(context, 'Error', 'Intente en unos minutos nuevamente');
          }
        }else{
          alert(context, 'Error', 'La asistencia ya no se encuentra habilitado / actualize para corraborar si no es ello espere unos minutos');
        }
      });
    }else{
      //alerta(context,'Contactar a soporte Tecnico',CoolAlertType.warning,'Error insertar');
      await alert(context,'Error','Contactar a soporte Tecnico');
    }
    
    //debugPrint(body);
    //usuariosemanahabilitadoupdate = await usuarioController.putSemanaActualizada(prefs.getString('email'), body);
    return true;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Future<void> llenarCursosAlumno() async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    UsuarioController usuarioController = UsuarioController();
    asistencia = await usuarioController.getAsistenciaHoy(prefs.getString('email'));
    //return true;
    //debugPrint(usuario.response.toString());
  }
  extraerList(List <dynamic> data,List arreglo,String value,String? value_1,String? value_2,String? value_3,String? value_4,String? value_5,String? value_6){
    setState(() {
      arreglo;
    });
    for(var x in data ){ 
      if (arreglo.contains(x[value].toString())){
        null;
      }else{
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
}