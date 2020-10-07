import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_answer_me/bloc/question_bloc.dart';
import 'package:flutter_answer_me/events/question_event.dart';
import 'package:flutter_answer_me/model/answers.dart';
import 'package:flutter_answer_me/model/questions.dart';
import 'package:flutter_answer_me/server_req/handle_server.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_answer_me/constants/constants.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final HandleServer server = new HandleServer();
  int numOfQuestion = 1; //current question display
  int index = 0; // list index
  String _userAnswer = ''; // user text answer
  List<Answers> answersList; // answer
  var answerTextController =
      TextEditingController(); // text controller to set previous answers
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form controller

  @override
  void initState() {
    super.initState();
    //getting the questions from the server and create list of questions + list of answers
    server.getUserQuestions().then((questionList) {
      BlocProvider.of<QuestionBloc>(context)
          .add(QuestionEvent.setApplication(questionList));
      answersList = List<Answers>.filled(
          // setting all question id to -1 = user didn't answer them yet.
          questionList.length, // same size as question list
          Answers(
            questionId: -1,
          ));
    });
  }

  void increaseIndex() {
    numOfQuestion++;
    index++;
  }

  void decreaseIndex() {
    numOfQuestion--;
    index--;
  }

  void nextQuestionFillUserAnswer() {
    answerTextController.text = answersList[index].answer;

    answerTextController.selection = TextSelection.fromPosition(
      TextPosition(offset: answerTextController.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.videocam),
              onPressed: () {
                print('Here you will need to navigate Experteasy');
              })
        ],
        title: Text('Questions'),
      ),
      body: Container(
        height: double.infinity, //set the background to fill all height
        decoration: kBackgroundDecorationStyle,
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
                            style: kQuestionHeadLineTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          items[index].question,
                          style: kQuestionTextStyle,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: answerTextController,
                          minLines: 3,
                          maxLines: 5,
                          onSaved: (value) {
                            _userAnswer = value;
                          },
                          validator: (value) {
                            if (value.length < 3) {
                              return 'Answer most be at least 3 characters';
                            }
                            if (value.trim().length <
                                3) // remove all spaces and check if there are more then 3 chars
                              return 'Answer most be at least 3 characters';

                            return null;
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
                          // if first question set the button in the middle else space evenly both buttons
                          mainAxisAlignment: numOfQuestion == 1
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceEvenly,
                          children: [
                            Visibility(
                              // if first question don't show back button
                              visible: numOfQuestion == 1 ? false : true,
                              child: RaisedButton(
                                color: Colors.redAccent,
                                textColor: Colors.white,
                                shape: StadiumBorder(),
                                onPressed: () {
                                  setState(() {
                                    if (numOfQuestion == items.length) {
                                      // last question save user answer
                                      _formKey.currentState.save();
                                      Answers temp = Answers(
                                          questionId: items[index].id,
                                          answer: _userAnswer,
                                          explanation: '');
                                      answersList[index] =
                                          temp; // not in demands just fill empty string before sending data
                                    }
                                    //follow the index and question numbers
                                    decreaseIndex();
                                    if (answersList[index].questionId !=
                                        -1) // if not -1 meaning user answer the question another option is to set all answers as '' and remove this if
                                      nextQuestionFillUserAnswer();
                                  });
                                },
                                child: Text('Back'),
                              ),
                            ),
                            numOfQuestion !=
                                    items
                                        .length // show next button only if the number on current question ot equal to questions.length
                                ? RaisedButton(
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      _formKey.currentState.save();
                                      if (_formKey.currentState.validate()) {
                                        Answers temp = Answers(
                                            questionId: items[index].id,
                                            answer: _userAnswer,
                                            explanation: '');
                                        answersList[index] =
                                            temp; // not in demands just fill empty string before sending data

                                        setState(
                                          () {
                                            increaseIndex();
                                            _formKey.currentState.reset();
                                            answerTextController
                                                .clear(); // clear the form
                                            _userAnswer = '';
                                            if (answersList[index].questionId !=
                                                -1) {
                                              nextQuestionFillUserAnswer();
                                            }
                                          },
                                        );
                                      }
                                    },
                                    child: Text('Next'),
                                    textColor: Colors.white,
                                    shape: StadiumBorder(),
                                  )
                                : RaisedButton(
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      _formKey.currentState.save();
                                      if (_formKey.currentState.validate()) {
                                        server
                                            .sendUserAnswer(answersList[1])
                                            .then((value) {
                                          print('The answer was send :$value');
                                        });
                                      }
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
