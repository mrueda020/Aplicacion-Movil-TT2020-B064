import 'respuesta.dart';
import 'examen.dart';
import 'pregunta.dart';
import 'questions_widget.dart';
import 'question_numbers_widget.dart';
import 'package:flutter/material.dart';
import 'package:linkex/Screens/menu_resultados.dart';

class ExamenPage extends StatefulWidget {
  final Examen examen;
  final String infoExamen;

  ExamenPage({Key key, this.examen, this.infoExamen}) : super(key: key);

  @override
  _ExamenPageState createState() => _ExamenPageState();
}

class _ExamenPageState extends State<ExamenPage> {
  PageController controller;
  Pregunta pregunta;
  int id = 0;
  int numPreguntas = 0;
  int numSeleccionado = 0;

  bool answered = false;
  var preguntas = new List(100);
  var idRespuesta = new List(100);
  String texto = "";

  @override
  void initState() {
    super.initState();

    controller = PageController();
    pregunta = widget.examen.preguntas_Examen.first;
    numPreguntas = widget.examen.preguntas_Examen.length;
  }

  void consultarPreguntas() {
    numSeleccionado = 0;
    for (int i = 0; i < numPreguntas; i++) {
      if (preguntas[i] != null) {
        numSeleccionado++;
      }
    }
    texto =
        'Esta seguro que desea terminar el examen? \n\nActualmente lleva contestado: \n' +
            numSeleccionado.toString() +
            ' de ' +
            numPreguntas.toString() +
            ' preguntas';
  }

  Future<bool> _onBackPressed() {
    consultarPreguntas();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              texto,
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.indigo[50],
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MenuResultadoPage(
                            numPreguntas,
                            preguntas,
                            widget.infoExamen,
                            idRespuesta)));
                  },
                  child: Text(
                    'Terminar',
                    style: TextStyle(
                      color: Colors.indigoAccent,
                      fontSize: 23.0,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.indigo[50],
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'Regresar',
                    style: TextStyle(
                      color: Colors.indigoAccent,
                      fontSize: 23.0,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.indigo[50],
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: buildAppBar(context),
          body: QuestionsWidget(
            examen: widget.examen,
            controller: controller,
            onChangedPage: (index) => siguientePregunta(index: index),
            onClickedOption: selectOption,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: () {
                    print(id);

                    if (id != 0) siguientePregunta(index: id - 1, jump: true);
                  },
                  icon: Icon(Icons.navigate_before),
                  label: Text(""),
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    print(widget.examen.preguntas_Examen.length);

                    if (id < widget.examen.preguntas_Examen.length - 1) {
                      siguientePregunta(index: id + 1, jump: true);
                    } else if (id ==
                        widget.examen.preguntas_Examen.length - 1) {
                      print("final");
                      _onBackPressed();
                    }
                  },
                  label: Text(id == widget.examen.preguntas_Examen.length - 1
                      ? "Terminar"
                      : ""),
                  icon: Icon(Icons.navigate_next),
                )
              ],
            ),
          )));

  Widget buildAppBar(context) => AppBar(
        title: Text(widget.examen.titulo),
        leading: GestureDetector(
          onTap: () {},
          child: Icon(Icons.schedule_send),
        ),
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                child: Text(
                  "SistemaEX  ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                ),
                onTap: () {},
              )
            ],
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF3C57F0),
                Color(0xFF3700FF),
              ],
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: QuestionNumbersWidget(
              preguntas: widget.examen.preguntas_Examen,
              pregunta: pregunta,
              onClickedNumber: (index) =>
                  siguientePregunta(index: index, jump: true),
            ),
          ),
        ),
      );

  void selectOption(Respuesta option) {
    if (pregunta.bloqueado) {
      return;
    } else {
      print(id);
      setState(() {
        pregunta.opcionSeleccionada = option;
        preguntas[id] = option.esCorrecto.toString();
        idRespuesta[id] = option.idRespuesta;
        print(preguntas[id]);
        print(idRespuesta[id]);
      });
    }
  }

  void siguientePregunta({int index, bool jump = false}) {
    id = index;

    final nextPage = controller.page + 1;
    final indexPage = index ?? nextPage.toInt();

    setState(() {
      pregunta = widget.examen.preguntas_Examen[indexPage];
    });

    if (jump) {
      controller.jumpToPage(indexPage);
    }
  }
}
