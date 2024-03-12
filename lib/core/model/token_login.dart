// To parse this JSON data, do
//
//     final tokenlogin = tokenloginFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Tokenlogin tokenloginFromJson(String str) =>
    Tokenlogin.fromJson(json.decode(str));

String tokenloginToJson(Tokenlogin data) => json.encode(data.toJson());

class Tokenlogin {
  final String username;
  final String image;
  final Tokens tokens;

  Tokenlogin({
    required this.username,
    required this.image,
    required this.tokens,
  });

  factory Tokenlogin.fromJson(Map<String, dynamic> json) => Tokenlogin(
        username: json["username"],
        image: json["image"],
        tokens: Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "image": image,
        "tokens": tokens.toJson(),
      };
}

class Tokens {
  final String refresh;
  final String access;

  Tokens({
    required this.refresh,
    required this.access,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}
