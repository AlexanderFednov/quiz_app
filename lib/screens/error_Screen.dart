import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String imageUrl;
  final String errorText;
  final String buttonText;
  final Function buttonFunction;

  ErrorScreen(
      {this.imageUrl, this.errorText, this.buttonFunction, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl), fit: BoxFit.cover)),
      child: Center(
        child: Container(
          height: 300,
          // width: double.infinity,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  errorText,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
              TextButton(
                  onPressed: buttonFunction,
                  child: Text(
                    buttonText,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
