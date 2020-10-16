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

  QuestionEvent.delete(int index) {
    this.eventType = EventType.delete;
    this.questionIndex = index;
  }

  QuestionEvent.setQuestions(List<Question> list) {
    this.eventType = EventType.setQuestions;
    this.questionList = list;
  }

  QuestionEvent.update(int index, Question question) {
    this.eventType = EventType.update;
    this.questionIndex = index;
    this.question = question;
  }
}
