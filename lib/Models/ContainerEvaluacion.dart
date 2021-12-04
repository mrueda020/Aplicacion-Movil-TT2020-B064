import 'dart:async';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:linkex/Models/CircleIndicator.dart';

class ContainerEvaluacion extends StatefulWidget {
  String materia;
  String fecha;
  String grupo;
  int calificacion;
  ContainerEvaluacion(
      {this.materia, this.fecha, this.calificacion, this.grupo});
  @override
  _ContainerEvaluacionState createState() => new _ContainerEvaluacionState();
}

class _ContainerEvaluacionState extends State<ContainerEvaluacion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 90,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    color: Colors.blueAccent,
                    width: 50,
                    height: 90,
                  ),
                  // ),
                  SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.materia,
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigoAccent[400],
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
                        Text(
                          'Grupo: ' + widget.grupo,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.indigo[50],
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Fecha: ' + widget.fecha,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
                  ProgressCircleIndicator(
                    completedPercentage: widget.calificacion,
                    radius: 35,
                    fontSize: 28,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 5),
                      ]),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
