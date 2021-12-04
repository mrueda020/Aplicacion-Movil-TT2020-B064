import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'question.dart';

class Category {
  String categoryName = "";
  List<Question> questions = [];

  Category({
    @required this.categoryName,
    @required this.questions,
  });

  @override
  String toString() {
    return 'Category: {categoryName: ${categoryName}, questions: ${questions}';
  }
}
