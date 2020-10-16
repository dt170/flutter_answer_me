import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_answer_me/model/questions.dart';
import 'package:flutter_answer_me/model/answers.dart';

class HandleServer {
  // final String baseUrl = 'http://localhost:5000/';
  //TODO: change this to final url when project deploy
  final String _baseUrl =
      'http://10.0.2.2:5000/'; // for using the emulator on android
  String _token;
  final String _postUserUrl = 'api/v1/questioned/answer';
  final String _getUserQuestionsUrl = 'api/v1/questioned/';
  final String _phoneVerification = 'api/v1/questioned/code';
  final String _smsVerification = 'api/v1/questioned/verify';

  // create singletone
  HandleServer._();
  static final HandleServer server = HandleServer._();

  Future<String> get token async {
    print("get token called");

    if (_token != null) {
      return _token;
    }
    //TODO: if token null this will cause error win using getUserQuestions() and sendUserAnswer()
    return null;
  }

// this function return the user question from server
  Future<List<Question>> getUserQuestions() async {
    List<Question> questionList = [];
    String url = _baseUrl + _getUserQuestionsUrl;

    final String tok = await token;
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url, headers: {"x-auth-token": tok});
    // if req was good handle the response
    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}\n');
      print('Response body: ${response.body}\n');
      List<dynamic> questionJson =
          convert.jsonDecode(response.body)['data']['questioned']['questions'];
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

  Future<bool> sendUserAnswer(Answers answer) async {
    String url = _baseUrl + _postUserUrl;
    final String tok = await token;
    var data = convert.jsonEncode(answer.toJson()); // encode the answer to json
    try {
      var response = await http.post(url,
          headers: {
            "x-auth-token": tok,
            "content-type": "application/json",
          },
          body: data);
      print('Response status: ${response.statusCode}\n');
      print('Response body: ${response.body}\n');
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print('Error in sendUserAnswer: $e');
      return false;
    }
    return false;
  }

// send the phone number to the server in order to get sms code
  Future<bool> authenticateUser(String phone) async {
    String url = _baseUrl + _phoneVerification;

    var data = convert
        .jsonEncode({"phoneNumber": "$phone"}); // encode the answer to json
    try {
      var response = await http.post(url,
          headers: {
            "content-type": "application/json",
          },
          body: data);
      print('Response status: ${response.statusCode}\n');
      print('Response body: ${response.body}\n');
      if (response.statusCode == 200) {
        print('authenticateUser was successful!');
        return true;
      }
    } catch (e) {
      print('Error in authenticateUser: $e');
      return false;
    }
    return false;
  }

  //send the user phone number and code for verification on the server
  Future<bool> verifySms(String phone, String code) async {
    String url = _baseUrl + _smsVerification;

    var data = convert.jsonEncode({
      "phoneNumber": "$phone",
      "code": "$code",
    }); // encode the answer to json
    try {
      var response = await http.post(url,
          headers: {
            "content-type": "application/json",
          },
          body: data);
      print('Response status: ${response.statusCode}\n');
      print('Response body: ${response.body}\n');
      if (response.statusCode == 200) {
        print('verifySms was successful!');
        var token = convert.jsonDecode(response.body)['data']['token'];
        print(token);
        //setting the token
        _setToken(token);
        return true;
      }
    } catch (e) {
      print('Error in verifySms: $e');
      return false;
    }
    return false;
  }

  void _setToken(String tok) {
    this._token = tok;
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
