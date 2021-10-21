import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

class MyCustomInputBox extends StatefulWidget {
  String label;
  String inputHint;
  bool obscureText;
  var formKey;
  TextEditingController controllerInput;
  MyCustomInputBox(
      {this.label,
      this.inputHint,
      this.obscureText,
      this.controllerInput,
      this.formKey});
  @override
  _MyCustomInputBoxState createState() => new _MyCustomInputBoxState();
}

class _MyCustomInputBoxState extends State<MyCustomInputBox> {
  bool isSubmitted = false;

  final checkBoxIcon = 'assets/images/check.png';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, bottom: 3.0),
            child: Text(
              widget.label,
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return '';
              } else {}
              return null;
            },
            style: TextStyle(
              color: Colors.indigo[700],
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
            controller: widget.controllerInput,
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(27),
                borderSide: BorderSide(color: Colors.red[400]),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(27),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              hintText: widget.inputHint,
              hintStyle: TextStyle(
                color: Color(0xffA6B0BD),
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
              contentPadding:
                  EdgeInsets.symmetric(vertical: 17, horizontal: 25),
              focusColor: Color(0xff0962ff),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27),
                  borderSide: BorderSide(
                    color: Color(0xff0962ff),
                  )),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(27),
                borderSide: BorderSide(
                  color: Colors.grey[350],
                ),
              ),
            ),
          ),
        ),

        //    )
      ],
    );
  }
}
