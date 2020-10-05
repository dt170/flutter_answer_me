import 'package:flutter/material.dart';
import 'package:flutter_answer_me/server_req/handle_server.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final HandleServer server = new HandleServer();

  @override
  void initState() {
    super.initState();
    server.getUserQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(),
      ),
    ));
  }
}
