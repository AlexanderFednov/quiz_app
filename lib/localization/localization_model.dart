import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LocalizationModel extends Equatable {
  final Locale currentLocale;

  LocalizationModel({
    this.currentLocale = const Locale('ru', 'RU'),
  });

  LocalizationModel copyWith({Locale? currentLocale}) {
    return LocalizationModel(
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }

  @override
  List<Object?> get props => [
        currentLocale,
      ];
}
