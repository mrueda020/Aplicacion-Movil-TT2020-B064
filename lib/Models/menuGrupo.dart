import 'package:jwt_decode/jwt_decode.dart';
import 'package:linkex/Models/menuExamenEX.dart';
import 'package:linkex/data/constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class Grupo extends StatefulWidget {
  String idUsuario;
  Grupo({this.idUsuario});

  @override
  _GrupoState createState() => new _GrupoState();
}

class _GrupoState extends State<Grupo> {
  TextEditingController editingController = TextEditingController();

  var listaGrupo = List();
  List items = List();

  Future<List> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(Constants.url.toString() +
        'cargar-grupos/' +
        widget.idUsuario.toString());
    final response = await http.get(url);
    //print(response.body);
    var datagrupo = json.decode(response.body.toString());
    print(datagrupo["data"]);
    return datagrupo["data"];

    //print(widget.idUsuario);

    //var datagrupo = response.body;
    //sharedPreferences.setString("grupo", datagrupo);
  }

  @override
  void initState() {
    inicio();
    super.initState();
  }

  void reset() {
    setState(() {});
  }

  void inicio() async {
    reset();
    Future<List> _futureOfList = getData();
    items = await _futureOfList;
    listaGrupo.clear();
    listaGrupo.addAll(items);
    print(listaGrupo.length);
    reset();
  }

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    FocusScopeNode currentFocus = FocusScope.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
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
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              //width: MediaQuery.of(context).size.width,

              //height: screenHeight * 0.38,
              //
              height: 300.0,
              //height: scrHeight * 0.38,
              width: double.infinity,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 20, bottom: 20),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 25,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Grupos",
                  style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 45.0,
                      fontWeight: FontWeight.w800,
                      /*shadows: [
                                  Shadow(
                                    blurRadius: 3.0,
                                    color: Colors.blue[50],
                                    offset: Offset(1.0, 0.5),
                                  ),
                                ],*/
                    ),
                  ),
                ),
                Container(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "  Selecciona un grupo...",
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w200,
                          /*shadows: [
                                  Shadow(
                                    blurRadius: 3.0,
                                    color: Colors.blue[50],
                                    offset: Offset(1.0, 0.5),
                                  ),
                                ],*/
                        ),
                      ),
                    ),
                  ],
                )),
                SizedBox(
                  height: 17,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: OuterClippedPart2(),
              child: Container(
                color: Color(0xD50066FF),
                //color: Color(0xFF09C6FF),
                width: scrWidth,
                height: scrHeight,
              ),
            ),
          ),
          ClipPath(
            clipper: OuterClippedPart(),
            child: Container(
              // color: Color(0xFF41EB16),
              color: Color(0xE346A6FF),
              width: scrWidth,
              height: scrHeight,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              //color: Colors.green,
              //color: Colors.indigoAccent[400],
              height: MediaQuery.of(context).size.height * 1.878,
              margin: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0x000000000),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 256,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "SistemaEX",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: scrHeight * 0.24),
            child: Material(
              color: Colors.grey[100],
              borderRadius: BorderRadius.only(
                  //bottomLeft: Radius.circular(100.0),

                  //Al
                  //topRight: Radius.circular(100.0),
                  ),
              child: Stack(children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            // height: 520,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                bottom: 8, top: 8, left: 5, right: 5),
                            // height: 520,
                            height: scrHeight / 1.3,
                            child: ListView.builder(
                              shrinkWrap: true,
                              //itemCount: items == null ? 0 : items.length,
                              itemCount: listaGrupo.length,
                              itemBuilder: (context, i) {
                                return new Container(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, bottom: 18, left: 7, right: 7),
                                  child: new GestureDetector(
                                    onTap: () async => await Navigator.of(
                                            context)
                                        .push(new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new MenuExamenesPage(
                                                  idGrupo: listaGrupo[i]
                                                          ['Gr_id']
                                                      .toString(),
                                                  idUsuario: widget.idUsuario,
                                                ))),
                                    child: new Card(
                                      color: Colors.white,
                                      elevation: 14.0,
                                      shadowColor: Color(0x7738A4FC),
                                      child: new ListTile(
                                        title: new Text(
                                          "Grupo : ${listaGrupo[i]['Gr_nombre']}",
                                          style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.indigoAccent[400],
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 5.0,
                                                  color: Colors.indigo[50],
                                                  offset: Offset(5.0, 5.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        leading: Container(
                                          margin: EdgeInsets.only(
                                            bottom: 2,
                                          ),
                                          width: 80,
                                          height: 70,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            child: Image.asset(
                                              "assets/images/usersicon.png",
                                              width: 72.0,
                                            ),
                                          ),
                                        ),
                                        subtitle: new Text(
                                          "Descripción : ${listaGrupo[i]['Gr_descripcion']}",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 5.0,
                                                color: Colors.indigo[50],
                                                offset: Offset(5.0, 5.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    //  ),
                                  ),
                                );
                              },
                            )),
                      ]),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    var controllPoint = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    //path.lineTo(size.width, 150);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class OuterClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.45, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.1);
    path.quadraticBezierTo(
        size.width * 0.9, size.height * 0.02, size.width * .6, 0);
    /*path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    */
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class OuterClippedPart2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.35, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.2);
    path.quadraticBezierTo(
        size.width * 0.9, size.height * 0.03, size.width * .4, 0);
    /*path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    */
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
