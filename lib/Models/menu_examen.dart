import 'dart:io';
import 'respuesta.dart';
import 'dart:convert';
import 'examen.dart';
import 'pregunta.dart';
import 'examen_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:linkex/data/constants.dart' as Constants;

class MenuExamenesPage extends StatefulWidget {
  String idGrupo;
  String idUsuario;
  MenuExamenesPage({this.idGrupo, this.idUsuario});

  @override
  _MenuExamenesPageState createState() => _MenuExamenesPageState();
}

class _MenuExamenesPageState extends State<MenuExamenesPage> {
  static SharedPreferences _prefs;
  static var existeExamen;
  static var colorExamen;

  var listaExamenes = List();
  var listaPregunta = List();
  var listaPreguntas = List();
  var listaRespuesta = List();
  var listaRespuestas = List();
  List listaEx = List();
  List items = List();

  List<List<Respuesta>> options2 = List();

  List<Pregunta> questions1 = [];

  Future<List> getData() async {
    var url = Uri.parse(Constants.url.toString() +
        'cargar-examanes/' +
        widget.idUsuario.toString() +
        '/' +
        widget.idGrupo.toString());
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: Constants.aToken,
      },
    );
    var datagrupo = json.decode(response.body.toString());

    print(datagrupo["data"]);
    return datagrupo["data"];
  }

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> _onBackPressed(String idExamen, String nombreExamen, int id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: Color(0x00ffffff),
            title: Text(
              'Desea iniciar \nel examen?',
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
                    getExamen(idExamen, nombreExamen, id);

                    // SystemNavigator.pop();
                  },
                  child: Text(
                    'Comenzar',
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

  Future<bool> _error() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: Color(0x00ffffff),
            title: Text(
              'El examen ya fue contestado.\nNo puede resolverse nuevamente.',
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
                    Navigator.of(context).pop(false);
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

  static initlist(int tamLista) async {
    existeExamen = new List(tamLista);
    colorExamen = new List(tamLista);
  }

  @override
  void initState() {
    inicio();
    //verificarExamen();
    super.initState();
  }

  void reset() {
    setState(() {});
  }

  void inicio() async {
    reset();
    Future<List> _futureOfList = getData();
    items = await _futureOfList;
    listaExamenes.clear();
    listaExamenes.addAll(items);
    initlist(listaExamenes.length);
    //verificar();
    init();
    print("lenght: ");
    print(listaExamenes.length);
    reset();
  }

  String extraerValor(List lista, int id, int id2, int id3) {
    String valor = "";
    List listaSplit1 = lista[id].split(':');
    print(listaSplit1);
    valor = listaSplit1[id2];
    return valor;
  }

  void verificar() {
    for (var i = 0; i < existeExamen.length; i++) {
      existeExamen[i] = _prefs == null
          ? "false"
          : json.decode(
              _prefs.getString(listaExamenes[i]["Exa_nombre"].toString()));
      colorExamen[i] =
          _prefs == null ? Colors.grey[50] : Colors.lightGreenAccent[100];
      print(existeExamen[i]);
    }
  }

  String obtenerInfoExamen(String idExamen, int id) {
    var now = DateTime.now();
    print(id);

    var fechaFin = listaExamenes[id]["Exa_fecha_aplicacion_fin"];
    var fechaInicio = listaExamenes[id]["Exa_fecha_aplicacion_inicio"];
    var fechaRealizacion = now.year.toString() +
        "-" +
        now.month.toString() +
        "-" +
        now.day.toString() +
        " " +
        now.hour.toString() +
        ":" +
        now.minute.toString() +
        ":" +
        now.second.toString();
    var idEvaluador = listaExamenes[id]["Evaluador_Evaluador_id"].toString();
    var tipoExamen = listaExamenes[id]["Exa_tipo_de_examen"].toString();

    String infoExamen = '{"fechaFin": "' +
        fechaFin +
        '", "fechaInicio": "' +
        fechaInicio +
        '", "fechaRealizacion": "' +
        fechaRealizacion +
        '", "idEvaluado": "' +
        widget.idUsuario +
        '", "idEvaluador": "' +
        idEvaluador +
        '", "idExamen": "' +
        idExamen.toString() +
        '", "idGrupo": "' +
        widget.idGrupo.toString() +
        '", "tipoExamen": "' +
        tipoExamen +
        '"}';

    return infoExamen;
  }

  Future<List> getExamen(String idExamen, String nombreExamen, int id) async {
    var url = Uri.parse(Constants.url.toString() +
        'cargar-examen/' +
        widget.idUsuario.toString() +
        '/' +
        idExamen +
        '/' +
        widget.idGrupo);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: Constants.aToken,
      },
    );

    var dataexamen = json.decode(response.body.toString());
    var datauser = response.body;

    if (dataexamen["data"] != "El examen ya fue contestado") {
      print(datauser);
      print("idExamen");
      print(idExamen);

      String infoExamen = obtenerInfoExamen(idExamen, id);

      _prefs.setString("tokenex", datauser);

      listaEx = await dataexamen["data"];
      listaPreguntas.clear();
      listaPregunta.clear();
      listaRespuestas.clear();
      listaPreguntas.addAll(listaEx);
      //options1.clear();
      questions1.clear();

      print(listaPreguntas);
      for (int i = 0; i < listaPreguntas.length; i++) {
        List<Respuesta> options1 = List();
        //options1.clear();
        listaRespuestas.clear();
        listaPregunta.add(listaPreguntas[i]["pregunta"][0]);

        print("A");
        String text = listaPregunta[i].toString();
        //print(text);
        List result = text.split(',');
        //print(result[1]);
        List result2 = result[1].split('{');
        //print(result2[0]);
        List result3 = result2[0].split(':');
        print(result3[1].trim());

        String text2 = listaPreguntas[i]["respuestas"].toString();
        //print(text2);
        List resps = text2.split('}');
        //print(resps[0]);
        //List resps2 = resps[0].split(',');
        listaRespuestas.clear();
        //print(resps.length);
        for (int j = 0; j < resps.length - 1; j++) {
          List resps2 = resps[j].split(',');
          for (int k = 0; k < resps2.length; k++) {
            if (j != 0 && k != 0)
              listaRespuestas.add(extraerValor(resps2, k, 1, id).trim());
            else if (j == 0)
              listaRespuestas.add(extraerValor(resps2, k, 1, id).trim());
          }
          print(listaRespuestas);
          options1.add(Respuesta(
              texto: listaRespuestas[1],
              idRespuesta: listaRespuestas[0].toString(),
              esCorrecto: listaRespuestas[2].toString() == "1" ? true : false));
          listaRespuestas.clear();

          print("Lista opciones");
        }
        options2.add(options1);
        print(options2[i]);
        questions1
            .add(Pregunta(texto: result3[1].trim(), opciones: options2[i]));
      }

      Examen nuevoExamen =
          new Examen(titulo: nombreExamen, preguntas_Examen: questions1);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ExamenPage(examen: nuevoExamen, infoExamen: infoExamen),
      ));
    } else {
      _error();
    }
  }

  void leerExamen() {}

  Future<bool> _DescargarExamen(String idExamen, String nombreExamen) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: Color(0x00ffffff),
            title: Text(
              'Deseas descargar el examen?',
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
                  onPressed: () {},
                  child: Text(
                    'Si',
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
                    'No',
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
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                //color: Color(0xFFD4E7FE),
                gradient: LinearGradient(
                    colors: [
                      Color(0xFF0072FD),
                      Color(0xFFF0F0F0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.6, 0.3])),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 155,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          text: "SistemaEX",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Examenes",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 38.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              top: 145,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      buildTitleRow("Proximos Examenes ", listaExamenes.length),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        //itemCount: listaExamenes == null ? 0 : listaExamenes.length,
                        itemCount: listaExamenes.length,
                        itemBuilder: (context, i) {
                          return new Container(
                              child: GestureDetector(
                                  onTap: () async => _onBackPressed(
                                      listaExamenes[i]["Exa_id"].toString(),
                                      listaExamenes[i]["Exa_nombre"].toString(),
                                      i),
                                  child: Column(
                                    children: [
                                      buildClassItem(
                                          listaExamenes[i][
                                                  "Exa_fecha_aplicacion_inicio"]
                                              .toString(),
                                          listaExamenes[i]["Exa_description"]
                                              .toString(),
                                          listaExamenes[i]["Exa_nombre"]
                                              .toString(),
                                          colorExamen[i])
                                    ],
                                  )));
                        },
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Container buildTaskItem(
      String estadoExamen, String tituloExamen, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(12),
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                estadoExamen,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 100,
            child: Text(
              tituloExamen,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Row buildTitleRow(String title, int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
              text: title,
              style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: "($number)",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        Text(
          "",
          style: TextStyle(
              fontSize: 12,
              color: Color(0XFF3E3993),
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Container buildClassItem(String horaAplicacion, String descripcion,
      String tituloExamen, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/images/pencilicon.png",
            width: 28.0,
          ),
          Container(
            height: 100,
            width: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 160,
                child: Text(
                  "$tituloExamen",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.black,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Text(
                      "Fecha: " + "$horaAplicacion",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Descripción: " + "$descripcion",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
