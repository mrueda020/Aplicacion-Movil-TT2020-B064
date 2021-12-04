import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linkex/Screens/aplicarExamen.dart';
import 'package:linkex/Screens/menuResultados.dart';
import 'category.dart';
import 'option.dart';
import 'question.dart';
import 'question_numbers_widget.dart';
import 'questions_widget.dart';

class CategoryPage extends StatefulWidget {
  final Category category;
  final String infoExamen;

  CategoryPage({Key key, this.category, this.infoExamen}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  PageController controller;
  Question question;
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
    question = widget.category.questions.first;
    numPreguntas = widget.category.questions.length;
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
            // backgroundColor: Color(0x00ffffff),
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
                    /* if (numSeleccionado < numPreguntas) {
                      Navigator.of(context).pop(false);
                      _onBackPressed();
                    } else {*/
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MenuResultadoPage(
                            numPreguntas,
                            preguntas,
                            widget.infoExamen,
                            idRespuesta)));
                    // }
                    // SystemNavigator.pop();
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
            category: widget.category,
            controller: controller,
            onChangedPage: (index) => nextQuestion(index: index),
            onClickedOption: selectOption,
          ),
          /*floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //question.isLocked = true;
            nextQuestion(index: temp + 1, jump: true);
          },
          backgroundColor: Colors.indigoAccent,
          icon: Icon(Icons.skip_next),
          label: Text("Siguiente"),
        ),*/
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

                    if (id != 0) nextQuestion(index: id - 1, jump: true);
                  },
                  icon: Icon(Icons.navigate_before),
                  label: Text(""),
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    //print(temp);
                    print(widget.category.questions.length);

                    if (id < widget.category.questions.length - 1) {
                      nextQuestion(index: id + 1, jump: true);
                    } else if (id == widget.category.questions.length - 1) {
                      print("final");
                      _onBackPressed();
                    }
                  },
                  label: Text(id == widget.category.questions.length - 1
                      ? "Terminar"
                      : ""),
                  icon: Icon(Icons.navigate_next),
                )
              ],
            ),
          )));

  Widget buildAppBar(context) => AppBar(
        title: Text(widget.category.categoryName),
        leading: GestureDetector(
          onTap: () {/* Write listener code here */},
          child: Icon(Icons.schedule_send // add custom icons also
              ),
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
                //Colors.blue.shade400,
                //Colors.lightBlue[100],
                Color(0xFF3700FF),

                //Color(0xFF0022FF),
                //Color(0xFF0A23C9),
              ],
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: QuestionNumbersWidget(
              questions: widget.category.questions,
              question: question,
              onClickedNumber: (index) =>
                  nextQuestion(index: index, jump: true),
            ),
          ),
        ),
      );

  void selectOption(Option option) {
    if (question.isLocked) {
      return;
    } else {
      print(id);
      setState(() {
        //question.isLocked = true;

        question.selectedOption = option;
        preguntas[id] = option.isCorrect.toString();
        idRespuesta[id] = option.code;
        print(preguntas[id]);
        print(idRespuesta[id]);
        /*QuestionNumbersWidget(
          questions: widget.category.questions,
          question: question,
          onClickedNumber: (index) =>
              nextQuestion(index: temp + 1, jump: false),
        );*/

        // nextQuestion(index: temp + 1, jump: true);
      });
    }
  }

  void nextQuestion({int index, bool jump = false}) {
    id = index;

    final nextPage = controller.page + 1;
    final indexPage = index ?? nextPage.toInt();

    setState(() {
      question = widget.category.questions[indexPage];
    });

    if (jump) {
      controller.jumpToPage(indexPage);
    }
  }
}
