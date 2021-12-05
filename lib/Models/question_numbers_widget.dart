import 'pregunta.dart';
import 'package:flutter/material.dart';

class QuestionNumbersWidget extends StatelessWidget {
  final List<Pregunta> preguntas;
  final Pregunta pregunta;
  final ValueChanged<int> onClickedNumber;

  const QuestionNumbersWidget({
    Key key,
    @required this.preguntas,
    @required this.pregunta,
    @required this.onClickedNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double padding = 16;

    return Container(
      height: 50,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: padding),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => Container(width: padding),
        itemCount: preguntas.length,
        itemBuilder: (context, index) {
          final isSelected = pregunta == preguntas[index];

          return buildNumber(
            index: index,
            isSelected: isSelected,
          );
        },
      ),
    );
  }

  Widget buildNumber({
    @required int index,
    @required bool isSelected,
  }) {
    final color = isSelected ? Colors.lightBlueAccent[200] : Colors.white;

    return GestureDetector(
      onTap: () => onClickedNumber(index),
      child: CircleAvatar(
        backgroundColor: color,
        child: Text(
          '${index + 1}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0026FF),
          ),
        ),
      ),
    );
  }
}
