class Car {
  final String name;
  final String imgUrl;

  Car(this.name, this.imgUrl);

  Car.fromJson(Map<String, dynamic> jsonMap)
      : name = jsonMap['nome'],
        imgUrl = jsonMap['urlFoto'];
}
