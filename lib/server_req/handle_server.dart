import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_answer_me/model/questions.dart';
import 'package:flutter_answer_me/model/answers.dart';

class HandleServer {
  // final String baseUrl = 'http://localhost:5000/';
  //TODO: change this to the final url when project deploy
  final String _baseUrl =
      'http://10.0.2.2:5000/'; // for using the emulator on android
  String _token;

  final String _postAnswersUrl = 'api/v1/questioned/answer';
  final String _getUserQuestionsUrl = 'api/v1/questioned/';
  final String _phoneVerification = 'api/v1/questioned/code';
  final String _smsVerification = 'api/v1/questioned/verify';

  // create static so the token will be saved after verification
  HandleServer._();
  static final HandleServer server = HandleServer._();

// this function return the user question from server
  Future<List<Question>> getUserQuestions() async {
    List<Question> questionList = [];
    String url = _baseUrl + _getUserQuestionsUrl;

    // final String tok = await token;
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url, headers: {"x-auth-token": _token});
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
    String url = _baseUrl + _postAnswersUrl;
    // final String tok = await token;
    var data = convert.jsonEncode(answer.toJson()); // encode the answer to json
    try {
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

  //set the token
  void _setToken(String tok) {
    this._token = tok;
  }
}
