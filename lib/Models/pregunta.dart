import 'package:flutter/cupertino.dart';

import 'respuesta.dart';

class Pregunta {
  final String texto;
  List<Respuesta> opciones = [];
  bool esCorrecto;
  bool bloqueado;
  Respuesta opcionSeleccionada;

  Pregunta({
    @required this.texto,
    @required this.opciones,
    this.esCorrecto = false,
    this.bloqueado = false,
    this.opcionSeleccionada,
  });

  @override
  String toString() {
    return 'Pregunta: {texto: ${texto}, opciones: ${opciones}';
  }
}
