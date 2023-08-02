import 'package:flutter/material.dart';
import 'package:flutter_application/views/login/widget/btnInicio.dart';
import 'package:flutter_application/views/login/widget/email.dart';
import 'package:flutter_application/views/login/widget/iconInicio.dart';
import 'package:flutter_application/views/login/widget/logo.dart';
import 'package:flutter_application/views/login/widget/password.dart';
import 'package:flutter_application/views/widget/created.dart';
class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    double largo = MediaQuery.of(context).size.height;
    return SizedBox(
      width: ancho,
      child: Material(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          width: ancho,
          height: largo,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  Logo(ancho, largo),
                  Spacer(),
                ],
              ),
              Email(ancho, largo),
              Password(ancho, largo),
              ButtonInicio(ancho, largo),
              IconInicio(ancho, largo),
              const Spacer(),
              Created(ancho, largo),
            ],
          ),
        ),
      ),
    );
  }
}