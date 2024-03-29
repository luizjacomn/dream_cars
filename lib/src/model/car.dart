import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarType {
  static const String classics = 'classicos';
  static const String sports = 'esportivos';
  static const String luxs = 'luxo';
}

class Car {
  final int id;
  String type;
  String name;
  String desc;
  String imgUrl;
  String urlVideo;
  String latitude;
  String longitude;

  Car({
    this.id,
    this.name,
    this.type,
    this.desc,
    this.imgUrl,
    this.urlVideo,
    this.latitude,
    this.longitude,
  });

  LatLng get latlng => LatLng(double.parse(latitude), double.parse(longitude));

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as int,
      name: json['nome'] as String,
      type: json['tipo'] as String,
      desc: json['desc'] as String,
      imgUrl: json['urlFoto'] as String,
      urlVideo: json['urlVideo'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "nome": name,
      "tipo": type,
      "desc": desc,
      "urlFoto": imgUrl,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Car[$id]: $name";
  }
}
