import 'dart:async';

import 'package:dream_cars/src/services/cars_service.dart';

class CarBloc {
  final _carsController = StreamController();

  fetch(String type) {
    CarsService.getCars(type).then((cars) {
      _carsController.sink.add(cars);
    });
  }

  Stream get outCars => _carsController.stream;

  void close() {
    _carsController.close();
  }
}