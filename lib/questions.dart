//import 'package:flutter/material.dart';

class Questions {
  final questionsAll = const [
    {
      'questionText': 'Фамилия певца - Иван ...',
      'answers': [
        {'text': 'Борн', 'result': false, 'code': 'A'},
        {'text': 'Горн', 'result': false, 'code': 'B'},
        {'text': 'Дорн', 'result': true, 'code': 'C'},
        {'text': 'Порн', 'result': false, 'code': 'D'},
      ],
    },
    {
      'questionText': 'Воинское звание Маршала Рыбалко',
      'answers': [
        {'text': 'Мастер', 'result': false, 'code': 'A'},
        {'text': 'Лейтенант', 'result': false, 'code': 'B'},
        {'text': 'Командир', 'result': false, 'code': 'C'},
        {'text': 'Маршал', 'result': true, 'code': 'D'},
      ],
    },
    {
      'questionText': 'Если внутрь кладут творог получается',
      'answers': [
        {'text': 'Горох', 'result': false, 'code': 'A'},
        {'text': 'Пирог', 'result': true, 'code': 'B'},
        {'text': 'Жирок', 'result': false, 'code': 'C'},
        {'text': 'Курок', 'result': false, 'code': 'D'},
      ],
    },
    {
      'questionText': 'Если поверху кладут, то ... зовут',
      'answers': [
        {'text': 'Хлопушкою', 'result': false, 'code': 'A'},
        {'text': 'Матрёшкою', 'result': false, 'code': 'B'},
        {'text': 'Ватрушкою', 'result': true, 'code': 'C'},
        {'text': 'Кадушкою', 'result': false, 'code': 'D'},
      ],
    },
    {
      'questionText': 'Супруга певца Л.Агутина',
      'answers': [
        {'text': 'Варлей', 'result': false, 'code': 'A'},
        {'text': 'Варум', 'result': true, 'code': 'B'},
        {'text': 'Влади', 'result': false, 'code': 'C'},
        {'text': 'Пугачёва', 'result': false, 'code': 'D'},
      ],
    },
  ];
  final questionsFilms = const [
    {
      'questionText':
          'Кто сыграл Шурика в комедии Л.Гайдая "Кавказская пленница"?',
      'answers': [
        {'text': 'Ю.Никулин', 'result': false, 'code': 'A'},
        {'text': 'С.Филипов', 'result': false, 'code': 'B'},
        {'text': 'А.Демьяненко', 'result': true, 'code': 'C'},
        {'text': 'А.Миронов', 'result': false, 'code': 'D'},
      ],
    },
    {
      'questionText': 'Режиссёр картины "Джентльмены удачи" 1971 г.',
      'answers': [
        {'text': 'А.Серый', 'result': true, 'code': 'A'},
        {'text': 'Г.Данелия', 'result': false, 'code': 'B'},
        {'text': 'А. Хачатурян', 'result': false, 'code': 'C'},
        {'text': 'М.Захаров', 'result': false, 'code': 'D'},
      ],
    },
    {
      'questionText': 'Фамилия главного героя картины "Афоня" 1975 г.',
      'answers': [
        {'text': 'Трошкин', 'result': false, 'code': 'A'},
        {'text': 'Суслин', 'result': false, 'code': 'B'},
        {'text': 'Петренко', 'result': false, 'code': 'C'},
        {'text': 'Борщёв', 'result': true, 'code': 'D'},
      ],
    },
    {
      'questionText':
          'Кто сыграл следователя Подберёзовикова в картине "Берегись автомобиля" 1966 г.',
      'answers': [
        {'text': 'И. Смоктуновский', 'result': false, 'code': 'A'},
        {'text': 'О. Ефремов', 'result': true, 'code': 'B'},
        {'text': 'А. Папанов', 'result': false, 'code': 'C'},
        {'text': 'Ю. Яковлев', 'result': false, 'code': 'D'},
      ],
    },
    {
      'questionText': 'Режиссёр картины "Приходите завтра" 1963 г.',
      'answers': [
        {'text': 'Л. Гайдай', 'result': false, 'code': 'A'},
        {'text': 'Э. Рязанов', 'result': false, 'code': 'B'},
        {'text': 'Е. Ташков', 'result': true, 'code': 'C'},
        {'text': 'И. Ильинский', 'result': false, 'code': 'D'},
      ],
    },
  ];

  final questionsSpace = const [
    {
      'questionText': 'Сколько планет в Солнечной системе?"',
      'answers': [
        {'text': '7', 'result': false, 'code': 'A'},
        {'text': '8', 'result': true, 'code': 'B'},
        {'text': '9', 'result': false, 'code': 'C'},
        {'text': '10', 'result': false, 'code': 'D'},
      ],
    },
    {
      'questionText': 'Самая горячая планета в солнечной системе?',
      'answers': [
        {'text': 'Марс', 'result': false, 'code': 'A'},
        {'text': 'Венера', 'result': true, 'code': 'B'},
        {'text': 'Нептун', 'result': false, 'code': 'C'},
        {'text': 'Сатурн', 'result': false, 'code': 'D'},
      ],
    },
    {
      'questionText': 'В каком году состоялась первая в мире высадка на Луну?',
      'answers': [
        {'text': '1962', 'result': false, 'code': 'A'},
        {'text': '1965', 'result': false, 'code': 'B'},
        {'text': '1969', 'result': true, 'code': 'C'},
        {'text': '1975', 'result': false, 'code': 'D'},
      ],
    },
    {
      'questionText':
          'Какое небесное тело в солнечной системе было лишено статуса классической планеты в 2006 г.?',
      'answers': [
        {'text': 'Сириус', 'result': false, 'code': 'A'},
        {'text': 'Большая медведица', 'result': false, 'code': 'B'},
        {'text': 'Венера', 'result': false, 'code': 'C'},
        {'text': 'Плутон', 'result': true, 'code': 'D'},
      ],
    },
    {
      'questionText': 'В каком году состоялся первый полёт человека в космос?',
      'answers': [
        {'text': '1960', 'result': false, 'code': 'A'},
        {'text': '1961', 'result': true, 'code': 'B'},
        {'text': '1962', 'result': false, 'code': 'C'},
        {'text': '1963', 'result': false, 'code': 'D'},
      ],
    },
  ];

  final questionNull = [
    {
      'questionText':
          'Сервер недоступен /n Вернитесь на главную страницу и выберите другую категорию или перезапустите приложение',
      'answers': [
        {'text': '-', 'result': false, 'code': 'A'},
        {'text': '-', 'result': false, 'code': 'B'},
        {'text': '-', 'result': true, 'code': 'C'},
        {'text': '-', 'result': false, 'code': 'D'},
      ],
    },
  ];
}
