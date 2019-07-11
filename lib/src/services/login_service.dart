import 'dart:convert';

import 'package:dream_cars/src/model/user.dart';
import 'package:dream_cars/src/utils/check_connectivity.dart';
import 'package:dream_cars/src/utils/response.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<Response> login(String user, String password) async {
    var connected = await hasConnection();
    if (!connected) {
      return Response('Error', 'No network connection');
    }

    try {
      var url = 'http://livrowebservices.com.br/rest/login';
      final response =
          await http.post(url, body: {'login': user, 'senha': password});
      final Response resp = Response.fromJson(json.decode(response.body));

      if (resp.isOk()) {
        final user = User('Luiz', 'luiz', 'luizjacomn@gmail.com');
        user.save();
      }

      return resp;
    } catch (ex) {
      return Response('Error', ex.toString());
    }
  }
}
