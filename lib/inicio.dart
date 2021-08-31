import 'package:flutter/material.dart';
import 'package:linkex/dashboard.dart';
import 'package:linkex/menuLateral.dart';

class Inicio extends StatefulWidget {
  final String id;
  final String name;
  final String username;
  final String image;

  Inicio({this.id, this.name, this.username, this.image});

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
            id: widget.id,
            name: widget.name,
            username: widget.username,
            image: widget.image,
          ),
          Dashboard(
            id: widget.id,
            name: widget.name,
            username: widget.username,
            image: widget.image,
          )
        ],
      ),
    );
  }
}
