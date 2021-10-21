import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:octo_image/octo_image.dart';

import 'package:google_fonts/google_fonts.dart';

import 'dart:async';
import 'dart:convert';

class ExamenPage extends StatefulWidget {
  @override
  _ExamenPageState createState() => new _ExamenPageState();
}

class _ExamenPageState extends State<ExamenPage> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    FocusScopeNode currentFocus = FocusScope.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        //primary: true,
        //extendBodyBehindAppBar: true,
        //resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: GestureDetector(
          onTap: () {},
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF3C57F0),
                        //Colors.blue.shade400,
                        //Colors.lightBlue[100],
                        Color(0xFF3700FF),

                        //Color(0xFF0022FF),
                        //Color(0xFF0A23C9),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  //width: MediaQuery.of(context).size.width,

                  //height: screenHeight * 0.38,
                  //
                  height: 300.0,
                  //height: scrHeight * 0.38,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 15, bottom: 5),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height / 25),
                        child: Row(
                          children: [
                            Text(
                              " Lenguajes de Programacion",
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  /*shadows: [
                                  Shadow(
                                    blurRadius: 3.0,
                                    color: Colors.blue[50],
                                    offset: Offset(1.0, 0.5),
                                  ),
                                ],*/
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            /* IconButton(
                              onPressed: () {
                                currentFocus.unfocus();

                                //_controller.clear();
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),*/
                          ],
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 7, right: 12, left: 0, bottom: 0),
                      height: scrHeight / 15,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: ['1', '2', '3', '4', '5', '6', '7']
                            .map((e) => Container(
                                  //margin: EdgeInsets.all(100.0),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFFD1D1D1),
                                          Color(0xFFFBFCFF),
                                        ],
                                      ),
                                      shape: BoxShape.circle),
                                  margin: EdgeInsets.only(
                                      top: 0, right: 0, left: 0, bottom: 0),
                                  child: OutlineButton(
                                    onPressed: () {
                                      //currentFocus.unfocus();
                                      currentFocus.hasFocus;
                                    },
                                    splashColor: Colors.lightBlue,
                                    shape: CircleBorder(),
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF0026FF),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipPath(
                  clipper: OuterClippedPart2(),
                  child: Container(
                    color: Color(0xD50066FF),
                    //color: Color(0xFF09C6FF),
                    width: scrWidth,
                    height: scrHeight,
                  ),
                ),
              ),
              ClipPath(
                clipper: OuterClippedPart(),
                child: Container(
                  // color: Color(0xFF41EB16),
                  color: Color(0xE346A6FF),
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(top: scrHeight * 0.24),
                child: Material(
                  color: Colors.grey[100],
                  child: Stack(children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 15.0,
                            ),
                            Center(
                              child: Text(
                                "1: Lenguaje de Programacion de la empresa X",
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w800,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 3.0,
                                        color: Colors.black12,
                                        offset: Offset(1.0, 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 15),
                              child: SizedBox(
                                width: 360.0,
                                height: 80.0,
                                child: Card(
                                  color: Colors.indigoAccent,
                                  elevation: 14.0,
                                  shadowColor: Color(0x7738A4FC),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(24.0)),
                                  child: InkWell(
                                    //hoverColor: Colors.indigoAccent,
                                    splashColor: Colors.white,
                                    borderRadius: BorderRadius.circular(24.0),
                                    onTap: () {
                                      setState(() {});
                                    },

                                    child: Container(
                                      margin: EdgeInsets.only(top: 5, left: 15),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.circle,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Text(
                                            "Respuesta 1",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 25.0,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 2.0,
                                                  color: Colors.black12,
                                                  offset: Offset(2.0, 2.0),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 15),
                              child: SizedBox(
                                width: 360.0,
                                height: 80.0,
                                child: Card(
                                  color: Colors.indigoAccent,
                                  elevation: 14.0,
                                  shadowColor: Color(0x7738A4FC),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(24.0)),
                                  child: InkWell(
                                    //hoverColor: Colors.indigoAccent,
                                    splashColor: Colors.white,
                                    borderRadius: BorderRadius.circular(24.0),
                                    onTap: () {
                                      setState(() {});
                                    },

                                    child: Container(
                                      margin: EdgeInsets.only(top: 5, left: 15),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.circle,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Text(
                                            "Respuesta 2",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 25.0,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 2.0,
                                                  color: Colors.black12,
                                                  offset: Offset(2.0, 2.0),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 15),
                              child: SizedBox(
                                width: 360.0,
                                height: 80.0,
                                child: Card(
                                  color: Colors.indigoAccent,
                                  elevation: 14.0,
                                  shadowColor: Color(0x7738A4FC),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(24.0)),
                                  child: InkWell(
                                    //hoverColor: Colors.indigoAccent,
                                    splashColor: Colors.white,
                                    borderRadius: BorderRadius.circular(24.0),
                                    onTap: () {
                                      setState(() {});
                                    },

                                    child: Container(
                                      margin: EdgeInsets.only(top: 5, left: 15),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.circle,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Text(
                                            "Respuesta 3",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 25.0,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 2.0,
                                                  color: Colors.black12,
                                                  offset: Offset(2.0, 2.0),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 15),
                              child: SizedBox(
                                width: 360.0,
                                height: 80.0,
                                child: Card(
                                  color: Colors.indigoAccent,
                                  elevation: 14.0,
                                  shadowColor: Color(0x7738A4FC),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(24.0)),
                                  child: InkWell(
                                    //hoverColor: Colors.indigoAccent,
                                    splashColor: Colors.white,
                                    borderRadius: BorderRadius.circular(24.0),
                                    onTap: () {
                                      setState(() {});
                                    },

                                    child: Container(
                                      margin: EdgeInsets.only(top: 5, left: 15),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.circle,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Text(
                                            "Respuesta 4",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 25.0,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 2.0,
                                                  color: Colors.black12,
                                                  offset: Offset(2.0, 2.0),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    )
                  ]),
                ),
              ),
            ],
          ),
        )));
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
    path.lineTo(0, size.height - 50);
    var controllPoint = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    //path.lineTo(size.width, 150);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class OuterClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.45, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.1);
    path.quadraticBezierTo(
        size.width * 0.9, size.height * 0.02, size.width * .6, 0);
    /*path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    */
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class OuterClippedPart2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.35, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.2);
    path.quadraticBezierTo(
        size.width * 0.9, size.height * 0.03, size.width * .4, 0);
    /*path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    */
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
