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
  int index = 0;
  bool isFinish = false;
  String _answer = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                  child: Form(
                    key: _formKey,
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
                          items[index].question,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          style: TextStyle(),
                          minLines: 3,
                          maxLines: 5,
                          onSaved: (value) {
                            _answer = value;
                          },
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
                          mainAxisAlignment: numOfQuestion == 1
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceEvenly,
                          children: [
                            Visibility(
                              visible: numOfQuestion == 1 ? false : true,
                              child: RaisedButton(
                                color: Colors.redAccent,
                                textColor: Colors.white,
                                shape: StadiumBorder(),
                                onPressed: () {
                                  setState(() {
                                    numOfQuestion--;
                                    index--;
                                  });
                                },
                                child: Text('Back'),
                              ),
                            ),
                            numOfQuestion != items.length
                                ? RaisedButton(
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      setState(() {
                                        numOfQuestion++;
                                        index++;
                                      });
                                    },
                                    child: Text('Next'),
                                    textColor: Colors.white,
                                    shape: StadiumBorder(),
                                  )
                                : RaisedButton(
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      _formKey.currentState.save();
                                      if (_formKey.currentState.validate()) {}
                                    },
                                    child: Text('Finish'),
                                    textColor: Colors.white,
                                    shape: StadiumBorder(),
                                  ),
                          ],
                        )
                      ],
                    ),
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
