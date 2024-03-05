// To parse this JSON data, do
//
//     final tokeModel = tokeModelFromJson(jsonString);

import 'dart:convert';

TokeModel tokeModelFromJson(String str) => TokeModel.fromJson(json.decode(str));

String tokeModelToJson(TokeModel data) => json.encode(data.toJson());

class TokeModel {
  final InformationUser informationUser;
  final Tokens tokens;

  TokeModel({
    required this.informationUser,
    required this.tokens,
  });

  factory TokeModel.fromJson(Map<String, dynamic> json) => TokeModel(
        informationUser: InformationUser.fromJson(json["information_user"]),
        tokens: Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "information_user": informationUser.toJson(),
        "tokens": tokens.toJson(),
      };
}

class InformationUser {
  final String email;
  final String username;

  InformationUser({
    required this.email,
    required this.username,
  });

  factory InformationUser.fromJson(Map<String, dynamic> json) =>
      InformationUser(
        email: json["email"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
      };
}

class Tokens {
  final String refresh;
  final String accsess;

  Tokens({
    required this.refresh,
    required this.accsess,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        refresh: json["refresh"],
        accsess: json["accsess"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "accsess": accsess,
      };
}
