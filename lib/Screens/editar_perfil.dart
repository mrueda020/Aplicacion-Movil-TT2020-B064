import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:linkex/Models/CustomInputBox.dart';
import 'package:linkex/data/constants.dart' as Constants;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditarPerfil extends StatefulWidget {
  final String idUsuario;
  EditarPerfil({this.idUsuario});

  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  TextEditingController oldPassCont = new TextEditingController();
  TextEditingController newPassCont = new TextEditingController();
  TextEditingController emailCont = new TextEditingController();
  bool showPassword = false;
  bool picked = false;
  bool cambiarPassword = false;
  var _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  Map<String, String> headers = {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': Constants.aToken
  };

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void initState() {
    //getData();
    //emailCont = new TextEditingController(text: widget.username);
    picked = false;
    cambiarPassword = false;
    super.initState();
  }

  Future<bool> _mensaje(String mensaje) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: Color(0x00ffffff),
            title: Text(
              mensaje,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
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
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pop(true);

                    // SystemNavigator.pop();
                  },
                  child: Text(
                    'Continuar',
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

  Future<List> actualizarInformacion() async {
    print(emailCont.text);
    print(oldPassCont.text);
    print(newPassCont.text);
    var url = Uri.parse(Constants.url.toString() +
        'actualizar-info/' +
        widget.idUsuario.toString());
    final bodyMsg = jsonEncode({
      "email": emailCont.text,
      "password": newPassCont.text,
      "confirmPassword": oldPassCont.text,
      "name": "",
      "surname": "",
    });
    final response = await http.post(url, headers: headers, body: bodyMsg);
    var dataresultados = json.decode(response.body.toString());
    print(response.body);
    if (response.body[2] == "e")
      _mensajeError(dataresultados["error"].toString());
    else
      _mensaje(dataresultados["message"].toString());
  }

  Future<List> actualizarInformacionEmail() async {
    print(emailCont.text);
    var url = Uri.parse(Constants.url.toString() +
        'actualizar-info/' +
        widget.idUsuario.toString());

    final bodyMsg = jsonEncode({
      "email": emailCont.text,
      "password": "",
      "confirmPassword": "",
      "name": "",
      "surname": "",
    });
    final response = await http.post(url, headers: headers, body: bodyMsg);
    var dataresultados = json.decode(response.body.toString());
    print(response.body);
    if (response.body[2] == "e")
      _mensajeError(dataresultados["error"].toString());
    else
      _mensaje(dataresultados["message"].toString());
  }

  Future<bool> _mensajeError(String mensaje) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: Color(0x00ffffff),
            title: Text(
              mensaje,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
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
                child: new Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.indigoAccent,
                    fontSize: 20.0,
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
                //color: Colors.green,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blueAccent,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
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
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                ),
                onTap: () {},
              )
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 0, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Ajustes",
                style: GoogleFonts.openSans(
                    textStyle:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                height: 5,
              ),
              cambiarPassword
                  ? Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        MyCustomInputBox(
                          controllerInput: emailCont,
                          label: 'Correo',
                          inputHint: 'Ingresa el correo',
                          obscureText: false,
                        ),
                        _buildPassSwitch(context),
                        SizedBox(
                          height: 10,
                        ),
                        MyCustomInputBox(
                          controllerInput: oldPassCont,
                          label: 'Nueva Contraseña',
                          inputHint: 'Ingresa una nueva contraseña',
                          obscureText: true,
                        ),
                        MyCustomInputBox(
                          controllerInput: newPassCont,
                          label: 'Confirmar Contraseña',
                          inputHint: 'Ingresa la nueva contraseña',
                          obscureText: true,
                          suffixIcons: InkWell(
                            onTap: _toggle,
                            child: Icon(
                              _obscureText
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              size: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              top: 15, bottom: 15, left: 28, right: 28),
                          decoration: BoxDecoration(
                              //color: Color(0xFF00B7FF),
                              color: Colors.blueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x60008FFF),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                  spreadRadius: 0,
                                ),
                              ]),
                          child: FlatButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                actualizarInformacion();
                              }
                            },
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "EDITAR",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    )
                  : Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        MyCustomInputBox(
                          controllerInput: emailCont,
                          label: 'Correo',
                          inputHint: 'Ingresa el correo',
                          obscureText: false,
                        ),
                        _buildPassSwitch(context),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              top: 15, bottom: 15, left: 28, right: 28),
                          decoration: BoxDecoration(
                              //color: Color(0xFF00B7FF),
                              color: Colors.blueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x60008FFF),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                  spreadRadius: 0,
                                ),
                              ]),
                          child: FlatButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              actualizarInformacionEmail();
                            },
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "EDITAR",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPassSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          'Cambiar Contraseña',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
            fontSize: 18,
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Colors.indigo[50],
                offset: Offset(5.0, 5.0),
              ),
            ],
          ),
        ),
        Switch(
            value: cambiarPassword,
            onChanged: (newVal) {
              cambiarPassword = newVal;
              setState(() {});
            }),
        //Text('Dark Theme'),
      ],
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
