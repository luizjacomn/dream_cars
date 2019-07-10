import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dream_cars/src/db/car_db.dart';
import 'package:dream_cars/src/model/car.dart';
import 'package:dream_cars/src/utils/check_connectivity.dart';
import 'package:dream_cars/src/utils/response.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class CarsService {
  static Future<List<Car>> getCars(String type) async {
    var connected = await hasConnection();
    if (!connected) {
      throw SocketException('No network connection');
    }

    final url = "http://livrowebservices.com.br/rest/carros/tipo/$type";

    final response = await http.get(url);

    final mapCarros = json.decode(response.body).cast<Map<String, dynamic>>();

    return mapCarros.map<Car>((json) => Car.fromJson(json)).toList();
  }

  static Future<Response> save(Car car, File file) async {
    if (file != null) {
      final uploadImage = await upload(file);
      car.imgUrl = uploadImage.url;
    }

    final url = "http://livrowebservices.com.br/rest/carros";

    final headers = {"Content-Type": "application/json"};
    final body = json.encode(car.toMap());

    final response = await http.post(url, headers: headers, body: body);

    final db = CarDB.getInstance();
    bool exists = await db.exists(car);
    if (exists) {
      db.save(car);
    }

    return Response.fromJson(json.decode(response.body));
  }

  static delete(Car car) async {
    final url = "http://livrowebservices.com.br/rest/carros/${car.id}";

    final response = await http.delete(url);

    final db = CarDB.getInstance();
    bool exists = await db.exists(car);
    if (exists) {
      db.delete(car.id);
    }

    return Response.fromJson(json.decode(response.body));
  }

  static Future<Response> upload(File file) async {
    final url = "http://livrowebservices.com.br/rest/carros/postFotoBase64";

    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    String fileName = path.basename(file.path);

    var body = {"fileName": fileName, "base64": base64Image};
    print("http.upload >> " + body.toString());

    final response = await http.post(url, body: body);

    print("http.upload << " + response.body);

    Map<String, dynamic> map = json.decode(response.body);

    return Response.fromJson(map);
  }

  static Future<String> getLoremIpsum() async {
    final url = 'http://loripsum.net/api';
    final response = await http.get(url);
    var body = response.body.replaceAll('<p>', '').replaceAll('</p>', '');
    return body;
  }
}
