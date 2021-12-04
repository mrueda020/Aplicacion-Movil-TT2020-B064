import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkex/Models/category_detail_widget.dart';
import 'package:linkex/Models/category_page.dart';
import 'package:linkex/Models/question.dart';
import 'package:linkex/Models/utils.dart';
import 'package:linkex/data/categories.dart';
import 'package:linkex/models/question.dart';
import 'package:linkex/data/constants.dart' as Constants;
import 'package:http/http.dart' as http;

import 'historial.dart';

class MenuResultadoPage extends StatefulWidget {
  final int preguntas;
  final List respuestas;
  final List idrespuestas;
  final String infoExamen;
  MenuResultadoPage(
      this.preguntas, this.respuestas, this.infoExamen, this.idrespuestas);

  @override
  _MenuResultadoPageState createState() => _MenuResultadoPageState();
}

class _MenuResultadoPageState extends State<MenuResultadoPage> {
  int correcto = 0;
  int calificacion = 0;
  String respuesta = "";
  var infoRespuesta;
  List array = List();
  var info;
  String infoid = "";

  @override
  void initState() {
    inicio();
    super.initState();
  }

  Future<List> sendData(int resultado) async {
    var url = Uri.parse(Constants.url.toString() + 'enviar-respuestasM');
    info = jsonDecode(widget.infoExamen);
    infoid = info["idEvaluado"].toString();
    print(correcto.toString());
    final response = await http.post(url, body: {
      "fechaFin": info["fechaFin"],
      "fechaInicio": info["fechaInicio"],
      "fechaRealizacion": info["fechaRealizacion"],
      "idEvaluado": info["idEvaluado"],
      "idEvaluador": info["idEvaluador"],
      "idExamen": info["idExamen"],
      "idGrupo": info["idGrupo"],
      "tipoExamen": info["tipoExamen"],
      "calificacion": resultado.toString(),
    });
    print(response.body);
  }

  inicio() {
    print("el tamano es");
    print(widget.idrespuestas);
    print(widget.preguntas);
    for (int i = 0; i < widget.preguntas; i++) {
      if (widget.respuestas[i] == "true") {
        respuesta = '{"idRespuesta": "' +
            widget.idrespuestas[i].toString() +
            '", "idPregunta": "' +
            (i + 1).toString() +
            '", "value": "1"}';
        infoRespuesta = jsonDecode(respuesta);
        array.add(infoRespuesta);
        correcto++;
      } else {
        respuesta = '{"idRespuesta": "' +
            widget.idrespuestas[i].toString() +
            '", "idPregunta": "' +
            (i + 1).toString() +
            '", "value": "0"}';

        infoRespuesta = jsonDecode(respuesta);
        array.add(infoRespuesta);
      }
    }
    calificacion = ((correcto / widget.preguntas) * 100).round();
    sendData(calificacion);
  }

  Future<bool> salir() {
    Navigator.of(context).pop(true);
    Navigator.of(context).pop(true);
    Navigator.of(context).pop(true);
    Navigator.of(context).pop(true);
    Navigator.of(context).pop(true);
    Navigator.of(context).pop(true);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => Historial(idUsuario: infoid)));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: salir,
      child: Material(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  //color: Color(0xFFD4E7FE),
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF0072FD),
                        Color(0xFFF0F0F0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.6, 0.3])),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () {
                            salir();
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 155,
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
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Resultados",
                            style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 38.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 145,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    //scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      buildClassItem(widget.preguntas.toString(), "Preguntas",
                          Colors.grey[50]),
                      SizedBox(
                        height: 20,
                      ),
                      buildClassItem(correcto.toString(),
                          "Respuestas Correctas", Colors.lightGreenAccent[100]),
                      SizedBox(
                        height: 20,
                      ),
                      buildClassItem((widget.preguntas - correcto).toString(),
                          "Respuestas Incorrectas", Colors.orangeAccent[100]),
                      SizedBox(
                        height: 25,
                      ),
                      buildClassItem(calificacion.toString() + "%",
                          "Calificación", Colors.blueAccent[100]),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildClassItem(String calificacion, String resultado, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$calificacion",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 27),
              ),
            ],
          ),
          Container(
            height: 100,
            width: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 160,
                child: Text(
                  "$resultado",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
