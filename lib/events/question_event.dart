import 'package:flutter_answer_me/model/questions.dart';

enum EventType { add, delete, setQuestions, update }

class QuestionEvent {
  Question question;
  int questionIndex;
  EventType eventType;
  List<Question> questionList;

  QuestionEvent.add(Question question) {
    this.eventType = EventType.add;
    this.question = question;
  }
  // for future option
  QuestionEvent.delete(int index) {
    this.eventType = EventType.delete;
    this.questionIndex = index;
  }

  QuestionEvent.setQuestions(List<Question> list) {
    this.eventType = EventType.setQuestions;
    this.questionList = list;
  }
  // for future option
  QuestionEvent.update(int index, Question question) {
    this.eventType = EventType.update;
    this.questionIndex = index;
    this.question = question;
  }
}
