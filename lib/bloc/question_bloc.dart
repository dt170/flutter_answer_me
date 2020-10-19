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
      //add question event
      case EventType.add:
        List<Question> newState = List.from(state);
        if (event.question != null) {
          newState.add(event.question);
        }
        yield newState;
        break;
      // for future option
      case EventType.delete:
        List<Question> newState = List.from(state);
        newState.removeAt(event.questionIndex);
        yield newState;
        break;
      //get all questions
      case EventType.setQuestions:
        yield event.questionList;
        break;
      // for future option
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
