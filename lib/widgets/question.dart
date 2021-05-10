import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
          color: Colors.white,),
      child: Text(
        questionText,
        softWrap: true,
        style: TextStyle(
            fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold,),
        textAlign: TextAlign.center,
      ),
    );
  }
}
