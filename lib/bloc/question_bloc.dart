import 'package:flutter_answer_me/model/questions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_answer_me/events/question_event.dart';

class QuestionBloc extends Bloc<QuestionEvent, List<Question>> {
  QuestionBloc() : super(List<Question>()) {
    // List<Question>();
  }

  @override
  Stream<List<Question>> mapEventToState(QuestionEvent event) async* {
    switch (event.eventType) {
      case EventType.add:
        List<Question> newState = List.from(state);
        if (event.question != null) {
          newState.add(event.question);
        }
        yield newState;
        break;
      case EventType.delete:
        List<Question> newState = List.from(state);
        newState.removeAt(event.questionIndex);
        yield newState;
        break;
      case EventType.setQuestions:
        yield event.questionList;
        break;
      case EventType.update:
        List<Question> newState = List.from(state);
        newState[event.questionIndex] = event.question;
        yield newState;
        break;
      default:
        throw Exception('error');
    }
  }
}
