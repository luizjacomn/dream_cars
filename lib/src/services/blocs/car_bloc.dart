import 'dart:async';

import 'package:dream_cars/src/model/car.dart';
import 'package:dream_cars/src/services/cars_service.dart';

class CarBloc {
  final _carsController = StreamController<List<Car>>();

  Future fetch(String type) {
    return CarsService.getCars(type).then((cars) {
      _carsController.sink.add(cars);
    }).catchError((error) {
      _carsController.addError(error);
    });
  }

  Stream<List<Car>> get outCars => _carsController.stream;

  void close() {
    _carsController.close();
  }
}
