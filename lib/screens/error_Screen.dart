import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/quizScreen/quiz_logic_bloc.dart';

class ErrorScreen extends StatelessWidget {
  final String? imageUrl;
  final String? errorText;
  final String? buttonText;

  ErrorScreen({
    this.imageUrl,
    this.errorText,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<QuizLogicBloc>(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl!),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          height: 300,
          // width: double.infinity,
          padding: EdgeInsets.all(5),
          // margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 0,
                child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    errorText!,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Flexible(
                flex: 0,
                child: TextButton(
                  onPressed: () => logicBloc.error(),
                  child: Text(
                    buttonText!,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
