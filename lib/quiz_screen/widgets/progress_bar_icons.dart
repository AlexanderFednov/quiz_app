import 'package:flutter/material.dart';

class IconTrueWidget extends StatelessWidget {
  const IconTrueWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
      ),
      child: Icon(
        Icons.brightness_1,
        color: Colors.green[800],
      ),
    );
  }
}

class IconFalseWidget extends StatelessWidget {
  const IconFalseWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
      ),
      child: Icon(
        Icons.brightness_1,
        color: Colors.red[900],
      ),
    );
  }
}
