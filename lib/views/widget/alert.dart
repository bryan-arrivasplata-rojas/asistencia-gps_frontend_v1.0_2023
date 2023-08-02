import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

Future<bool> alert(context,String title,String message)async{
  return (await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),//,textAlign: TextAlign.center,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
          child: const Text('OK'),
        ),
      ],
    ),
  )) ??
  false;
}
alerta(context,text,CoolAlertType type,title){
  CoolAlert.show(
    context: context,
    type: type,
    text: text,
    title: title,
    //loopAnimation: false,
    loopAnimation: false,
    backgroundColor: const Color(0xff800404),
    barrierDismissible: false,
    /*widget: TextFormField(
      decoration: const InputDecoration(
        hintText: 'Enter Phone Number',
        prefixIcon: Icon(
          Icons.phone_outlined,
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      //onChanged: (value) => '' = value,
    ),*/
    //autoCloseDuration: const Duration(seconds: 3),
    //confirmBtnText: 'Yes',
    //cancelBtnText: 'No',
    //confirmBtnColor: Colors.green,
  );
}

/*Future<bool> _onWillPop() async {
  return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit an App'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
              child: new Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // <-- SEE HERE
              child: new Text('Yes'),
            ),
          ],
        ),
      )) ??
      false;*/
