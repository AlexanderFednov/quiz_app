import 'package:flutter/material.dart';
//allias

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;
  final String codeAnswer;

  Answer(this.selectHandler, this.answerText, this.codeAnswer);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      //borderRadius: BorderRadius.circular(20),
      //border: Border.all(color: Colors.black, width: 1),
      //color: Colors.blueGrey),
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: selectHandler,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.blueGrey),
          animationDuration: Duration(milliseconds: 1),
          textStyle: MaterialStateProperty.all(
            TextStyle(color: Colors.white),
          ),
        ),
        child: Row(
          children: <Widget>[
            Text(
              '$codeAnswer)  ',
              softWrap: true,
              style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              answerText,
              style: TextStyle(fontSize: 25, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
