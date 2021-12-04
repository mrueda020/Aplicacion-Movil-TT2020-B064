import 'package:flutter/material.dart';
import 'option.dart';
import 'question.dart';
import 'package:linkex/models/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionsWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;

  const OptionsWidget({
    Key key,
    @required this.question,
    @required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        physics: BouncingScrollPhysics(),
        children: Utils.heightBetween(
          question.options
              .map((option) => buildOption(context, option))
              .toList(),
          height: 8,
        ),
      );

  Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, question);

    return GestureDetector(
      onTap: () => onClickedOption(option),

      /*child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            buildAnswer(option),
            buildSolution(question.selectedOption, option),
          ],
        ),
      ),*/
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
              buildSolution(question.selectedOption, option),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnswer(Option option) => Container(
        margin: EdgeInsets.only(top: 0, left: 15),
        height: 50,
        child: Row(children: [
          Icon(
            Icons.circle,
            color: Colors.white,
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            option.text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 20.0,
              shadows: [
                Shadow(
                  blurRadius: 2.0,
                  color: Colors.black12,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          )
        ]),
      );

  Widget buildSolution(Option solution, Option answer) {
    if (solution == answer) {
      question.solution = true;
      return Text(
        "",
        //question.solution,
        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
      );
    } else {
      question.solution = false;
      return Container();
    }
  }

  Color getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;

    if (!isSelected) {
      return Colors.indigoAccent;
    } else {
      return option.isCorrect ? Colors.lightBlue[200] : Colors.lightBlue[400];
    }
  }
}
