import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_answer_me/constants/constants.dart';

class FinishScreen extends StatefulWidget {
  static const String id = 'finish_screen';
  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            leading: Container(),
          ),
          backgroundColor: Colors.blue,
          body: Container(
            height: double.infinity, //set the background to fill all height
            decoration: kBackgroundDecorationStyle,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Answers sent successfully!',
                      style: kQuestionHeadLineTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'The application will be closed shortly',
                    style: kQuestionTextStyle.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
