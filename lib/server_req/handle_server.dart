import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_answer_me/model/questions.dart';
import 'package:flutter_answer_me/model/answers.dart';

class HandleServer {
  // final String baseUrl = 'http://localhost:5000/';
  //TODO: change this to final url when project deploy
  final String _baseUrl =
      'http://10.0.2.2:5000/'; // for using the emulator on android
  final String _token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOnsicXVlc3Rpb25lZElkIjoiNWY3OWY3ZmEyMjQzOTViN2I5MGFlZjk3In0sInJvbGUiOiJRVUVTVElPTkVEIiwiaWF0IjoxNjAxODI5OTIwLCJleHAiOjE2Mzc4Mjk5MjB9.mG9XdGGXOwYu9Xwqu1Htu4XbHPQU2HkxwYMybzpL3ms';
  final String _postUserUrl = 'api/v1/questioned/answer';
  final String _getUserQuestionsUrl = 'api/v1/questioned/';

  //TODO: add try and catch to prevent crashing
// this function return the user question from server
  Future<List<Question>> getUserQuestions() async {
    List<Question> questionList = [];
    String url = _baseUrl + _getUserQuestionsUrl;
    print('full url: $url');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url, headers: {"x-auth-token": _token});
    // if req was good handle the response
    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}\n');
      print('Response body: ${response.body}\n');
      List<dynamic> questionJson =
          convert.jsonDecode(response.body)['questions'];
      // adding all the questions into a list of question with all the data from json
      for (final q in questionJson) {
        Question question = Question.fromJson(q);
        questionList.add(question);
      }

      return questionList;
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }

  //TODO: add try and catch to prevent crashing
  Future<bool> sendUserAnswer(Answers answer) async {
    String url = _baseUrl + _postUserUrl;

    var data = convert.jsonEncode(answer.toJson()); // encode the answer to json
    var response = await http.post(url,
        headers: {
          "x-auth-token": _token,
          "content-type": "application/json",
        },
        body: data);
    print('Response status: ${response.statusCode}\n');
    print('Response body: ${response.body}\n');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
// Example for response getUserQuestion json
  /**
   *{
      "answers":{

      },
      "_id":"5f79f7fa224395b7b90aef97",
      "firstName":"Dvir",
      "lastName":"Dvir",
      "phoneNumber":"+972526573552",
      "questions":[
      {
      "question":"1????",
      "questionerName":"Marcos Molina",
      "description":"",
      "_id":7
      },
      {
      "question":"2????",
      "questionerName":"Marcos Molina",
      "description":"",
      "_id":8
      },
      {
      "question":"3????",
      "questionerName":"Marcos Molina",
      "description":"Exampleee",
      "_id":9
      }
      ],
      "__v":3
      }
   * **/
}
