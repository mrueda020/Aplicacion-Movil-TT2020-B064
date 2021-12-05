import 'respuesta.dart';
import 'pregunta.dart';
import 'examen.dart';
import 'options_widget.dart';
import 'package:flutter/material.dart';

class QuestionsWidget extends StatelessWidget {
  final Examen examen;
  final PageController controller;
  final ValueChanged<int> onChangedPage;
  final ValueChanged<Respuesta> onClickedOption;

  const QuestionsWidget({
    Key key,
    @required this.examen,
    @required this.controller,
    @required this.onChangedPage,
    @required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PageView.builder(
        onPageChanged: onChangedPage,
        controller: controller,
        itemCount: examen.preguntas_Examen.length,
        itemBuilder: (context, index) {
          final pregunta = examen.preguntas_Examen[index];
          //print(question);

          return buildQuestion(pregunta: pregunta);
        },
      );

  Widget buildQuestion({
    @required Pregunta pregunta,
  }) =>
      Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              pregunta.texto,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 8),
            Text(
              'Selecciona una respuesta',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
            SizedBox(height: 18),
            Expanded(
              child: OptionsWidget(
                pregunta: pregunta,
                onClickedOption: onClickedOption,
              ),
            ),
          ],
        ),
      );
}
