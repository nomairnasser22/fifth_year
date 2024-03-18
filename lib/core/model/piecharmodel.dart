// To parse this JSON data, do
//
//     final piecharModel = piecharModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PiecharModel> piecharModelFromJson(String str) => List<PiecharModel>.from(
    json.decode(str).map((x) => PiecharModel.fromJson(x)));

String piecharModelToJson(List<PiecharModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PiecharModel {
  final String expenseType;
  final int sum;

  PiecharModel({
    required this.expenseType,
    required this.sum,
  });

  factory PiecharModel.fromJson(Map<String, dynamic> json) => PiecharModel(
        expenseType: json["expense_type"],
        sum: json["sum"],
      );

  Map<String, dynamic> toJson() => {
        "expense_type": expenseType,
        "sum": sum,
      };
}
