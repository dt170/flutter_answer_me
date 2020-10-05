class Question {
  Question({
    this.question,
    this.questionerName,
    this.description,
    this.id,
  });

  String question;
  String questionerName;
  String description;
  int id;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        questionerName: json["questionerName"],
        description: json["description"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "questionerName": questionerName,
        "description": description,
        "_id": id,
      };
}
