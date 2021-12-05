import 'respuesta.dart';
import 'pregunta.dart';
import 'package:flutter/material.dart';
import 'package:linkex/models/utils.dart';

class OptionsWidget extends StatelessWidget {
  final Pregunta pregunta;
  final ValueChanged<Respuesta> onClickedOption;

  const OptionsWidget({
    Key key,
    @required this.pregunta,
    @required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        physics: BouncingScrollPhysics(),
        children: Utils.heightBetween(
          pregunta.opciones
              .map((option) => buildOption(context, option))
              .toList(),
          height: 2.5,
        ),
      );

  Widget buildOption(BuildContext context, Respuesta option) {
    final color = getColorForOption(option, pregunta);

    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Card(
          color: color,
          elevation: 14.0,
          shadowColor: Color(0x7738A4FC),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Column(
            children: [
              buildAnswer(option),
              buildSolution(pregunta.opcionSeleccionada, option),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnswer(Respuesta option) => Container(
        margin: EdgeInsets.only(top: 0, left: 15),
        height: 55,
        child: Row(children: [
          Icon(
            Icons.circle,
            color: Colors.white,
          ),
          SizedBox(
            width: 15.0,
          ),
          SizedBox(
            width: 150,
            child: Text(
              option.texto,
              maxLines: 2,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 19.0,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black12,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
        ]),
      );

  Widget buildSolution(Respuesta solution, Respuesta answer) {
    if (solution == answer) {
      pregunta.esCorrecto = true;
      return Text(
        "",
        //question.solution,
        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
      );
    } else {
      pregunta.esCorrecto = false;
      return Container();
    }
  }

  Color getColorForOption(Respuesta option, Pregunta pregunta) {
    final isSelected = option == pregunta.opcionSeleccionada;

    if (!isSelected) {
      return Colors.indigoAccent;
    } else {
      return option.esCorrecto ? Colors.lightBlue[200] : Colors.lightBlue[400];
    }
  }
}
