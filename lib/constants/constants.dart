import 'package:flutter/material.dart';

const kQuestionHeadLineTextStyle = TextStyle(
  fontSize: 25,
  color: Colors.white,
  shadows: [
    Shadow(
      color: Colors.black,
      blurRadius: 0.2,
      offset: Offset(2.0, 2.0),
    )
  ],
  fontWeight: FontWeight.bold,
);

const kQuestionTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

const kBackgroundDecorationStyle = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Colors.blueAccent,
      Colors.lightBlueAccent
    ], // need to check why its red
  ),
);
