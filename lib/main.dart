import 'package:flutter/material.dart';
import 'package:flutter_answer_me/screens/finish_screen.dart';
import 'package:flutter_answer_me/screens/question_screen.dart';
import 'screens/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/question_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuestionBloc>(
      create: (context) => QuestionBloc(),
      child: MaterialApp(
        title: 'Answer me',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Login.id,
        routes: {
          Login.id: (context) => Login(),
          FinishScreen.id: (context) => FinishScreen(),
          QuestionScreen.id: (context) => QuestionScreen(),
        },
      ),
    );
  }
}
