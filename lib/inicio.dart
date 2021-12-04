import 'package:flutter/material.dart';
import 'package:linkex/dashboard.dart';
import 'package:linkex/menuLateral.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';

class Inicio extends StatefulWidget {
  final String idUsuario;

  Inicio({this.idUsuario});
  @override
  _InicioState2 createState() => new _InicioState2();
}

class _InicioState2 extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MenuLateral(
            idUsuario: widget.idUsuario,
          ),
          Dashboard(
            idUsuario: widget.idUsuario,
          )
        ],
      ),
    );
  }
}
