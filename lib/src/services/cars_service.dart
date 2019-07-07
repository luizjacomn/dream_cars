import 'dart:async';
import 'dart:convert';
import 'package:dream_cars/src/model/car.dart';
import 'package:http/http.dart' as http;

class CarsService {
  static Future<List<Car>> getCars(String type) async {
    final url = "http://livrowebservices.com.br/rest/carros/tipo/$type";
    print("> get: $url");

    final response = await http.get(url);

//    print("< : ${response.body}");

    final mapCarros = json.decode(response.body).cast<Map<String, dynamic>>();

    return mapCarros.map<Car>((json) => Car.fromJson(json)).toList();
  }
}
