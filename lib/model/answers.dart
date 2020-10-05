class Answers {
  int questionId;
  String answer;
  String explanation = '';

  Answers({this.questionId, this.answer, this.explanation});

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "answer": answer,
        "explanation": explanation,
      };
}
