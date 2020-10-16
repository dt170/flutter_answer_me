class Answers {
  int questionId;
  String answer = '';
  String explanation = '';
  String date = '${DateTime.now()}';

  Answers({this.questionId, this.answer, this.explanation});

  //turn the answer object to json
  Map<String, dynamic> toJson() => {
        "questionId": '${this.questionId}',
        "answer": '${this.answer}',
        "explanation": '${this.explanation}',
        "date": '${this.date}',
      };
}
