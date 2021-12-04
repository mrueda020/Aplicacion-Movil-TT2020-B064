import 'package:flutter/cupertino.dart';

import 'option.dart';

class Question {
  final String text;
  List<Option> options = [];
  bool solution;
  bool isLocked;
  Option selectedOption;

  Question({
    @required this.text,
    @required this.options,
    this.solution = false,
    this.isLocked = false,
    this.selectedOption,
  });

  @override
  String toString() {
    return 'Question: {text: ${text}, options: ${options}';
  }
}
