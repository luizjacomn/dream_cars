import 'package:dream_cars/src/model/car.dart';

class CarsService {
  static List<Car> getCars() {
    return List.generate(
        2,
        (index) => Car('Mustang - ${index + 1}',
            'http://www.livroandroid.com.br/livro/carros/classicos/Ford_Mustang.png'));
  }
}
