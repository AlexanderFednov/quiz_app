import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  final Color pageColor;
  final String pageText;
  final Function swap;

  Quiz({this.pageColor, this.pageText, this.swap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(pageText),
            TextButton(
              child: Text('Сменить страницу'),
              onPressed: swap,
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(color: pageColor),
    );
  }
}
