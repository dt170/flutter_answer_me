import 'package:flutter/material.dart';
import 'package:flutter_answer_me/bloc/question_bloc.dart';
import 'package:flutter_answer_me/events/question_event.dart';
import 'package:flutter_answer_me/model/questions.dart';
import 'package:flutter_answer_me/server_req/handle_server.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final HandleServer server = new HandleServer();
  List<Question> quesList = [];
  int numOfQuestion = 1;
  @override
  void initState() {
    super.initState();
    server.getUserQuestions().then((questionList) {
      BlocProvider.of<QuestionBloc>(context)
          .add(QuestionEvent.setApplication(questionList));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions'),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.blueAccent, Colors.lightBlueAccent])),
        child: BlocConsumer<QuestionBloc, List<Question>>(
          builder: (context, items) {
            if (items.length != 0)
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                          child: Text(
                        'Question $numOfQuestion of ${items.length}',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      )),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        items[numOfQuestion].question,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextField(
                        style: TextStyle(),
                        minLines: 3,
                        maxLines: 5,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Answer',
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            onPressed: () {},
                            child: Text('Next'),
                          ),
                          RaisedButton(
                            onPressed: () {},
                            child: Text('Back'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
          listener: (BuildContext context, appList) {},
        ),
      ),
    );
  }
}
