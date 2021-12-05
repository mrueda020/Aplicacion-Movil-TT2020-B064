import 'package:flutter/material.dart';
import 'package:linkex/dashboard.dart';
import 'package:linkex/menu_lateral.dart';

class Inicio extends StatefulWidget {
  final String idUsuario;
  final String nombreUsuario;

  Inicio({this.idUsuario, this.nombreUsuario});
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
            nombreUsuario: widget.nombreUsuario,
          ),
          Dashboard(
            idUsuario: widget.idUsuario,
          )
        ],
      ),
    );
  }
}
