import 'package:linkex/data/constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:linkex/Models/CircleIndicator.dart';
import 'package:linkex/Models/ContainerEvaluacion.dart';
import 'dart:async';
import 'dart:convert';

class Historial extends StatefulWidget {
  String idUsuario;
  Historial({this.idUsuario});

  @override
  _HistorialState createState() => new _HistorialState();
}

class _HistorialState extends State<Historial> {
  // TextEditingController codigoCont;
  TextEditingController nombreCont;
  TextEditingController descripcionCont;
  TextEditingController stockCont;
  TextEditingController catCont;
  var _formKey = GlobalKey<FormState>();
  var listaResultados = List();
  List items = List();

  @override
  void initState() {
    inicio();
  }

  Future<List> getData() async {
    var url = Uri.parse(
        Constants.url.toString() + 'resultados/' + widget.idUsuario.toString());
    final response = await http.get(url);
    var dataresultados = json.decode(response.body.toString());
    return dataresultados;
  }

  void reset() {
    setState(() {});
  }

  void inicio() async {
    reset();
    Future<List> _futureOfList = getData();
    items = await _futureOfList;
    listaResultados.clear();
    listaResultados.addAll(items);
    print(listaResultados.length);
    print(listaResultados);
    reset();
  }

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        //physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            ClipPath(
              clipper: OuterClippedPart(),
              child: Container(
                // color: Color(0xFF41EB16),
                color: Color(0xFF09C6FF),
                width: scrWidth,
                height: scrHeight,
              ),
            ),
            ClipPath(
              clipper: InnerClippedPart(),
              child: Container(
                //color: Color(0xFF17740B),
                color: Color(0xFF170B81),
                width: scrWidth,
                height: scrHeight,
              ),
            ),
            Align(
              child: Row(
                children: [
                  SizedBox(
                    height: 85,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 130,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text: "SistemaEX",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 40.0),
                    child: Text(
                      "Historial",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.indigo[50],
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 36),
                ),
                Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            // height: 520,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                bottom: 0, top: 8, left: 5, right: 5),
                            // height: 520,
                            height: scrHeight / 1.2,
                            child: ListView.builder(
                              shrinkWrap: true,
                              //itemCount: items == null ? 0 : items.length,
                              itemCount: listaResultados.length,
                              itemBuilder: (context, i) {
                                return new Container(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, bottom: 0, left: 7, right: 7),
                                  child: ContainerEvaluacion(
                                    materia: listaResultados[i]["Exa_nombre"],
                                    grupo: listaResultados[i]["Gr_nombre"],
                                    fecha: listaResultados[i]
                                        ["Resultados_fecha_de_realizacion"],
                                    calificacion: listaResultados[i]
                                        ["Resultados_calificacion"],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                /*Form(
                  child: Column(
                    children: <Widget>[
                      ContainerEvaluacion(
                        materia: "Lenguajes de Programacion",
                        fecha: "2021-01-21 04:33:20",
                        calificacion: 50,
                      ),
                      ContainerEvaluacion(
                        materia: "Estructura de Datos",
                        fecha: "2021-09-05 05:19:11",
                        calificacion: 85,
                      ),
                      ContainerEvaluacion(
                        materia: "Base de Datos",
                        fecha: "2021-09-05 03:10:00",
                        calificacion: 100,
                      ),
                      ContainerEvaluacion(
                        materia: "Teoria Computacional",
                        fecha: "2021-08-12 03:20:00",
                        calificacion: 0,
                      ),
                      ContainerEvaluacion(
                        materia: "Analisis de Algoritmos",
                        fecha: "2021-01-01 05:30:30",
                        calificacion: 32,
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OuterClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 5.5);
    path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class InnerClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.7, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.1);
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.11, size.width * 0.7, 0);
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
