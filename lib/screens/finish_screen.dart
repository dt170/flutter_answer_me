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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.blue,
        body: Container(
          height: double.infinity, //set the background to fill all height
          decoration: kBackgroundDecorationStyle,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Answers sent successfully!',
                    style: kQuestionHeadLineTextStyle,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                RaisedButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    print('exit from application');
                    //this will exit from the application be aware it works for android not for ios
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  textColor: Colors.white,
                  shape: StadiumBorder(),
                  child: Text('Exit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
