import 'dart:convert';

import 'package:dream_cars/src/utils/response.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<Response> login(String user, String password) async {
    var url = 'http://livrowebservices.com.br/rest/login';
    final response =
        await http.post(url, body: {'login': user, 'senha': password});
    final Response resp = Response.fromJson(json.decode(response.body));
    return resp;
  }
}
