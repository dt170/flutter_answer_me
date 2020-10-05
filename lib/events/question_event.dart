import 'package:flutter_answer_me/model/questions.dart';

enum EventType { add, delete, setApplication, update }

class QuestionEvent {
  Question question;
  int questionIndex;
  EventType eventType;
  List<Question> questionList;

  QuestionEvent.add(Question application) {
    this.eventType = EventType.add;
    this.question = application;
  }

  QuestionEvent.delete(int index) {
    this.eventType = EventType.delete;
    this.questionIndex = index;
  }

  QuestionEvent.setApplication(List<Question> list) {
    this.eventType = EventType.setApplication;
    this.questionList = list;
  }

  QuestionEvent.update(int index, Question application) {
    this.eventType = EventType.update;
    this.questionIndex = index;
    this.question = application;
  }
}
