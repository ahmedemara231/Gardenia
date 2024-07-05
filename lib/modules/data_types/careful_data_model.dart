import 'package:flutter/material.dart';

class CarefulDataModel {
  String carefulSubTitle;
  Widget icon;
  String title;
  String? subTitle;

  CarefulDataModel({
    required this.carefulSubTitle,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  factory CarefulDataModel.fromJson(Map<String, dynamic> carefulData)
  {
    return CarefulDataModel(
        carefulSubTitle: carefulData['carefulSubTitle'],
        icon: carefulData['icon'],
        title: carefulData['title'],
        subTitle: carefulData['subTitle']
    );
  }
}