class Answers {
  int questionId;
  String answer = '';
  String explanation = '';

  Answers({this.questionId, this.answer, this.explanation});

  Map<String, dynamic> toJson() => {
        "questionId": '${this.questionId}',
        "answer": '${this.answer}',
        "explanation": '${this.explanation}',
      };
}
