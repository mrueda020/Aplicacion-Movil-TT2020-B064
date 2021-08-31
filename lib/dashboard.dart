import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  final String id;
  final String name;
  final String username;
  final String image;

  Dashboard({this.id, this.name, this.username, this.image});

  @override
  _DashboardState createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  String qrCode = '-1';
  String saludo = "BIENVENIDO";

  @override
  void initState() {
    _getTime();
    super.initState();
  }

  void _getTime() {
    var now = DateTime.now();
    if (int.parse(now.hour.toString()) >= 7) {
      print("Buenos Días");
      // saludo = "BUENOS DÍAS";
    } else if (int.parse(now.hour.toString()) >= 12 ||
        int.parse(now.hour.toString()) < 20) {
      print("Buenas Tardes");
      //saludo = "BUENAS TARDES";
    } else {
      print("Buenas Noches");
      //saludo = "BUENAS NOCHES";
    }
    print(now.hour.toString() +
        ":" +
        now.minute.toString() +
        ":" +
        now.second.toString());
    print(now);
  }

  bool isDrawerOpen = false;
  Future<bool> _onBackPressed() {
    if (isDrawerOpen) {
      setState(() {
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      });
    } else {
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
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isHovering = false;
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.3 : 0),
      duration: Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(isDrawerOpen ? 60 : 0.0),
            topLeft: Radius.circular(isDrawerOpen ? 60 : 0.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.blue[800],
            offset: Offset(1.0, 1.0),
            spreadRadius: 5.0,
          ),
        ],
      ),
      //backgroundColor: Colors.grey[100],
      //backgroundColor: Colors.grey[50],
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                xOffset = 0;
                yOffset = 0;
                scaleFactor = 1;
                isDrawerOpen = false;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 280.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          //Color(0xFF3383CD),
                          Colors.indigoAccent[400],
                          //Colors.lightBlue[100],
                          Color(0xff008FFF)
                          //Color(0xFF11249F),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(isDrawerOpen ? 60 : 0.0),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              isDrawerOpen
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                        size: 36.0,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          xOffset = 0;
                                          yOffset = 0;
                                          scaleFactor = 1;
                                          isDrawerOpen = false;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.notes_rounded,
                                        color: Colors.white,
                                        size: 36.0,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          xOffset = 230;
                                          yOffset = 150;
                                          scaleFactor = 0.6;
                                          isDrawerOpen = true;
                                        });
                                      }),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 18.0, left: 18, right: 18, top: 8),
                          child: Text(
                            saludo + "\n Elige una opción"
                            //+ widget.name
                            ,
                            //newname,
                            style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 38.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 12.0, left: 12, right: 12, top: 4),
                  child: Center(
                    child: Wrap(
                      spacing: MediaQuery.of(context).size.height / 40,
                      runSpacing: MediaQuery.of(context).size.height / 40.0,
                      children: <Widget>[
                        SizedBox(
                          width: 160.0,
                          height: 160.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 14.0,
                            shadowColor: Color(0x7738A4FC),

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0)),
                            //shadowColor: Colors.indigo[100],
                            child: InkWell(
                              //hoverColor: Colors.indigoAccent,
                              splashColor: Colors.indigoAccent[400],
                              borderRadius: BorderRadius.circular(24.0),
                              onTap: () {
                                setState(() {
                                  xOffset = 0;
                                  yOffset = 0;
                                  scaleFactor = 1;
                                  isDrawerOpen = false;
                                });
                              },
                              child: Container(
                                  child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/images/pencilicon.png",
                                      width: 64.0,
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      "Exámen",
                                      style: TextStyle(
                                        color: Colors.indigoAccent[400],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 5.0,
                                            color: Colors.indigo[50],
                                            offset: Offset(5.0, 5.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 160.0,
                          height: 160.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 14.0,
                            shadowColor: Color(0x7738A4FC),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0)),
                            child: InkWell(
                              //hoverColor: Colors.indigoAccent,
                              splashColor: Colors.amberAccent[700],
                              borderRadius: BorderRadius.circular(24.0),
                              onTap: () {
                                setState(() {
                                  xOffset = 0;
                                  yOffset = 0;
                                  scaleFactor = 1;
                                  isDrawerOpen = false;
                                });
                              },

                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/statusicon.png",
                                        width: 64.0,
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        "Historial",
                                        style: TextStyle(
                                          color: Colors.amberAccent[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 5.0,
                                              color: Colors.indigo[50],
                                              offset: Offset(5.0, 5.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 160.0,
                          height: 160.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 14.0,
                            shadowColor: Color(0x7738A4FC),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0)),
                            child: InkWell(
                                //hoverColor: Colors.indigoAccent,
                                splashColor: Colors.redAccent[700],
                                borderRadius: BorderRadius.circular(24.0),
                                onTap: () {
                                  setState(() {
                                    xOffset = 0;
                                    yOffset = 0;
                                    scaleFactor = 1;
                                    isDrawerOpen = false;
                                  });
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/images/listicon.png",
                                          width: 64.0,
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Text(
                                          "Resultados",
                                          style: TextStyle(
                                            color: Colors.redAccent[700],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 5.0,
                                                color: Colors.indigo[50],
                                                offset: Offset(5.0, 5.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 160.0,
                          height: 160.0,
                          child: Card(
                            color: Colors.white,
                            elevation: 14.0,
                            shadowColor: Color(0x7738A4FC),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0)),
                            child: InkWell(
                              //hoverColor: Colors.indigoAccent,
                              splashColor: Colors.greenAccent[700],
                              borderRadius: BorderRadius.circular(24.0),
                              onTap: () {
                                setState(() {
                                  xOffset = 0;
                                  yOffset = 0;
                                  scaleFactor = 1;
                                  isDrawerOpen = false;
                                });
                              },
                              child: Container(
                                  child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/images/usersicon.png",
                                      width: 72.0,
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      "Comentarios",
                                      style: TextStyle(
                                        color: Colors.greenAccent[700],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 5.0,
                                            color: Colors.indigo[50],
                                            offset: Offset(5.0, 5.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
