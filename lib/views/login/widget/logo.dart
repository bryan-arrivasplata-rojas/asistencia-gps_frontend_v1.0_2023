import 'package:flutter/material.dart';
// ignore: must_be_immutable
class Logo extends StatelessWidget {
  double ancho;
  double largo;
  Logo(this.ancho, this.largo,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // logouniiSV (18:79)
      margin:EdgeInsets.fromLTRB(0, 10 * largo/ancho, 0, 10 * largo/ancho),
      width: 100 * largo/ancho,
      height: 127 * largo/ancho,
      decoration: const BoxDecoration (
        color: Color(0xffffffff),
      ),
      child: Image.asset(
        'assets/logouni.png',
        fit: BoxFit.cover,
      ),
    );
  }
}