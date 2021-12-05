import 'dart:async';
import 'package:flutter/material.dart';
import 'package:linkex/configuration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/editar_perfil.dart';

class MenuLateral extends StatefulWidget {
  final String idUsuario;
  final String nombreUsuario;
  MenuLateral({this.idUsuario, this.nombreUsuario});

  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  List duplicateItems = List();
  String newusername = "";
  String newname = "";
  String newimage = "no_image.jpg";

  @override
  void initState() {
    super.initState();
  }

  void menu(String) async {
    if (String == 'Salir') {
      _onBackPressed();
    } else if (String == 'Ajustes') {
      Route route = MaterialPageRoute(
          builder: (context) => EditarPerfil(
                idUsuario: widget.idUsuario,
              ));
      Navigator.push(context, route);
    }
  }

  onGoBack(dynamic value) {
    Navigator.of(context).pop(true);
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: Color(0x00ffffff),
            title: Text(
              'Deseas cerrar la aplicación?',
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.indigo[50],
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pop(true);

                    // SystemNavigator.pop();
                  },
                  child: Text(
                    'Si',
                    style: TextStyle(
                      color: Colors.indigoAccent,
                      fontSize: 23.0,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.indigo[50],
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: Colors.indigoAccent,
                      fontSize: 23.0,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.indigo[50],
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.indigoAccent[700],
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.indigoAccent[700],
            Colors.lightBlueAccent[100],
          ],
        ),
      ),
      padding: EdgeInsets.only(top: 40, bottom: 270, left: 10, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 30, bottom: 0, left: 0, right: 210),
                child: CircleAvatar(
                    child: Image.asset("assets/images/usericon.png"),
                    radius: 52),
              ),
              SizedBox(
                width: 10,
                //height: 10,
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 15, bottom: 0, left: 10, right: 220),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nombreUsuario,
                      // newname,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Text('',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          ),
          Column(
            children: menuOpcionesDashboard
                .map((elemento) => Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, bottom: 5, left: 3, right: 150),
                      child: Card(
                        color: Color(0x0000000000),
                        elevation: 14.0,
                        shadowColor: Color(0x0000000000),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0)),
                        child: InkWell(
                          splashColor: Color(0xFF00CCFF),
                          borderRadius: BorderRadius.circular(24.0),
                          onTap: () => menu(elemento['title']),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    elemento['iconPath'],
                                    width: 32.0,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(elemento['title'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
