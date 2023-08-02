import 'package:flutter/material.dart';
// ignore: must_be_immutable
class Email extends StatelessWidget {
  double ancho;
  double largo;

  static TextEditingController emailController = TextEditingController(text:"");
  
  Email(this.ancho, this.largo, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      // emailNX3 (16:55)
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 9),
      padding:const EdgeInsets.fromLTRB(21, 7, 0, 7),
      //width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff800404),
      ),
      child: TextField(
        controller: emailController,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.1725,
          color: Color(0xffffffff),),
        decoration: const InputDecoration(
          hintText: 'Correo Institucional',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}