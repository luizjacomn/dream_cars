import 'dart:convert';

import 'package:dream_cars/src/utils/prefs.dart';

class User {
  final String name;
  final String login;
  final String email;

  User(this.name, this.login, this.email);

  User.fromJson(Map<String, dynamic> map)
      : this.name = map["nome"],
        this.login = map["login"],
        this.email = map["email"];

  void save() {
    final map = {"nome": name, "login": login, "email": email};
    Prefs.setString("user.prefs", json.encode(map));
  }

  static Future<User> get() async {
    String s = await Prefs.getString("user.prefs");
    if (s == null || s.isEmpty) {
      return null;
    }
    final user = User.fromJson(json.decode(s));
    return user;
  }

  static clear() {
    Prefs.setString("user.prefs", "");
  }
}
