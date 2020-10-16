import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_answer_me/screens/question_screen.dart';
import 'package:flutter_answer_me/server_req/handle_server.dart';
//import 'package:flutter_answer_me/screens/splash.dart';
import 'package:flutter_answer_me/widgets/custom_button.dart';
import 'package:flutter_answer_me/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController number = TextEditingController();
  TextEditingController code = TextEditingController();

  Future<void> _showMyFinishDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Please enter SMS code'),
          content: CupertinoTextField(
            controller: code,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: FlatButton(
                onPressed: () async {
                  bool response = await HandleServer.server
                      .verifySms(number.text, code.text);
                  print(response);
                  if (response)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuestionScreen()),
                    );
                },
                child: Text('Done'),
              ),
            ),
            CupertinoDialogAction(
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: // auth.loading
              //  ? Splash()
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/login.png",
                  width: 250,
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomText(text: "Answer me", size: 28, weight: FontWeight.bold),
            SizedBox(height: 5),
            RichText(
                text: TextSpan(children: [
              TextSpan(text: "Welcome to the"),
              TextSpan(
                  text: " Answer me",
                  style: TextStyle(color: Colors.blue.shade900)),
              TextSpan(text: " app"),
            ], style: TextStyle(color: Colors.black))),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(2, 1),
                          blurRadius: 2)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9|+]")),
                    ],
                    decoration: InputDecoration(
                        icon: Icon(Icons.phone_android, color: Colors.grey),
                        border: InputBorder.none,
                        hintText: "+123 45678 786",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Sen",
                            fontSize: 18)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "After entering your phone number, click on verify to authenticate yourself! Then wait up to 20 seconds to get th OTP and procede",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 10),
            CustomButton(
                msg: "Verify",
                onTap: () async {
                  bool result =
                      await HandleServer.server.authenticateUser(number.text);
                  if (result) _showMyFinishDialog();
                })
          ]),
        ),
      ),
    );
  }
}
