import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final Function swap1;
  final Function swap2;
  final Function swap3;

  MainPage({this.swap1, this.swap2, this.swap3});

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
                'Весёлая викторина',
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
                        'Выберите категорию:',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      CategoryButton(
                        category: 'Общие вопросы',
                        swap: swap1,
                        categoryColor: Colors.yellow,
                      ),
                      CategoryButton(
                        category: 'Кинофильмы СССР',
                        swap: swap2,
                        categoryColor: Colors.redAccent,
                      ),
                      CategoryButton(
                        category: 'Космос',
                        swap: swap3,
                        categoryColor: Colors.blue[800],
                      ),
                    ],
                  )),
            ),
            Text(
              'Fednov Studios 2021',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 15),
            )
          ],
        ));
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
      child: FlatButton(
        child: Text(
          category,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        onPressed: swap,
      ),
    );
  }
}
