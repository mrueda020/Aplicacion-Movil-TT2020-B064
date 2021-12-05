import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Respuesta {
  final String idRespuesta;
  final String texto;
  final bool esCorrecto;

  const Respuesta({
    @required this.texto,
    @required this.idRespuesta,
    @required this.esCorrecto,
  });

  @override
  String toString() {
    return 'Respuesta: {idRespuesta: ${idRespuesta}, texto: ${texto}, esCorrecto: ${esCorrecto}}';
  }
}
