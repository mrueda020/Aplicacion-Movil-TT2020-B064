import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:linkex/Models/CustomInputBox.dart';
//import 'package:linkex/Screens/elegirImagenPerfil.dart';
//import 'package:prueba/pages/imagenPickPerfil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

class EditarPerfil extends StatefulWidget {
  final String id;
  final String name;
  final String username;
  final String image;

  EditarPerfil({this.id, this.name, this.username, this.image});

  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  TextEditingController oldPassCont = new TextEditingController();
  TextEditingController newPassCont = new TextEditingController();
  TextEditingController idCont;
  TextEditingController nameCont;
  TextEditingController usernameCont;
  bool showPassword = false;
  File _image;
  String fileName = "no_image.png";
  final picker = ImagePicker();
  bool picked = false;
  bool cambiarPassword = false;
  var _formKey = GlobalKey<FormState>();

  void initState() {
    //getData();
    idCont = new TextEditingController(text: widget.id);
    nameCont = new TextEditingController(text: widget.name);
    usernameCont = new TextEditingController(text: widget.username);
    picked = false;
    cambiarPassword = false;
    super.initState();
  }

  void editDataSImgSPass() async {
    Navigator.of(context).pop(true);
  }

  void editDataSImgConPass() async {
    Navigator.of(context).pop(true);
  }

  void editDataConImgConPass() async {
    Navigator.of(context).pop(true);
  }

  void editDataConImgSPass() async {
    Navigator.of(context).pop(true);
  }

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      //_image = File(pickedImage.path);
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        picked = true;
      } else {
        picked = false;
        print('No ha seleccionado una imágen');
      }
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // backgroundColor: Color(0x00ffffff),
            title: Text(
              "La contraseña actual ingresada es incorrecta",
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

  Future<List> verificarPass() async {}

  Future uploadImage() async {
    /*

    //editData();
    setStateIfMounted(f) {
      if (mounted) setState(f);
    }*/

    //setState(() {});
  }

  Future uploadImage2() async {
    /*

    //editData();
    setStateIfMounted(f) {
      if (mounted) setState(f);
    }*/

    //setState(() {});
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
        /*actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.blueAccent,
            ),
            onPressed: () {},
          ),
        ],*/
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
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _image == null
                                ? NetworkImage(
                                    'https://linkex2020.000webhostapp.com/no_image.png')
                                : FileImage(_image)),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.blueAccent,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              choiceImage();
                            },
                          ),
                        )),
                  ],
                ),
              ),
              cambiarPassword
                  ? Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        MyCustomInputBox(
                          controllerInput: usernameCont,
                          label: 'Usuario',
                          inputHint: 'Ingresa el nombre de usuario',
                          obscureText: false,
                        ),
                        _buildPassSwitch(context),
                        SizedBox(
                          height: 10,
                        ),
                        MyCustomInputBox(
                          controllerInput: oldPassCont,
                          label: 'Contraseña Actual',
                          inputHint: 'Ingresa la contraseña actual',
                          obscureText: true,
                        ),
                        MyCustomInputBox(
                          controllerInput: newPassCont,
                          label: 'Nueva Contraseña',
                          inputHint: 'Ingresa una nueva contraseña',
                          obscureText: true,
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
                                verificarPass();
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
                          controllerInput: usernameCont,
                          label: 'Usuario',
                          inputHint: 'Ingresa el nombre de usuario',
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
                              picked ? uploadImage() : editDataSImgSPass();
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
