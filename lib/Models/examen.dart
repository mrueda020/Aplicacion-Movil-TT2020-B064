import 'pregunta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Examen {
  String titulo = "";
  List<Pregunta> preguntas_Examen = [];

  Examen({
    @required this.titulo,
    @required this.preguntas_Examen,
  });

  @override
  String toString() {
    return 'Examen: {titulo: ${titulo}, preguntas_Examen: ${preguntas_Examen}';
  }
}
