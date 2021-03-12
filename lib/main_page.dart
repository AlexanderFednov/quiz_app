import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
//import 'package:json_annotation/json_annotation.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:intl/intl.dart';
import 'generated/l10n.dart';

class MainPage extends StatelessWidget {
  final Function swap1;
  final Function swap2;
  final Function swap3;
  final Function localeRu;
  final Function localeEn;

  MainPage({this.swap1, this.swap2, this.swap3, this.localeRu, this.localeEn});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.network(
                      'https://ped-kopilka.ru/images/photos/medium/article8962.jpg')
                  .image,
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Text(
              S.of(context).title,
              style: TextStyle(
                color: Colors.pink,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          Center(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.pink, width: 10)),
                child: Column(
                  children: <Widget>[
                    Text(
                      S.of(context).categotyChoice,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    CategoryButton(
                      category: S.of(context).questionsAll,
                      swap: swap1,
                      categoryColor: Colors.yellow,
                    ),
                    CategoryButton(
                      category: S.of(context).questionsFilms,
                      swap: swap2,
                      categoryColor: Colors.redAccent,
                    ),
                    CategoryButton(
                      category: S.of(context).questionsSpace,
                      swap: swap3,
                      categoryColor: Colors.blue[800],
                    ),
                  ],
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedButton(
                child: Text('Русский',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                onPressed: localeRu,
                width: 110,
                height: 30,
                color: Colors.cyan,
              ),
              SizedBox(
                width: 10,
              ),
              AnimatedButton(
                child: Text(
                  'English',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                onPressed: localeEn,
                width: 110,
                height: 30,
                color: Colors.pink[100],
              )
            ],
          ),
          Text(
            'Fednov Studios 2021',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 15),
          )
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String category;
  final Function swap;
  final Color categoryColor;

  CategoryButton({this.category, this.swap, this.categoryColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(color: categoryColor),
      child: TextButton(
        child: Text(
          category,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        onPressed: swap,
      ),
    );
  }
}
