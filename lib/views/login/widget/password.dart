import 'package:flutter/material.dart';
// ignore: must_be_immutable
class Password extends StatelessWidget {
  double ancho;
  double largo;
  static TextEditingController passwordController = TextEditingController(text:"");
  Password(this.ancho, this.largo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // password9pd (16:59)
      //margin:EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
      padding:const EdgeInsets.fromLTRB(21, 7, 0, 7),
      //width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff800404),
      ),
      child: TextField(
        controller: passwordController,
        obscureText: true,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.1725,
          color: Color(0xffffffff),
        ),
        decoration: const InputDecoration(
          hintText: 'Contraseña',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}