import 'package:dream_cars/src/model/car.dart';

class CarsService {
  static List<Car> getCars() {
    var imgUrl =
        'http://www.livroandroid.com.br/livro/carros/classicos/Ford_Mustang.png';
    var imgUrl2 =
        'https://robbreportedit.files.wordpress.com/2018/02/13.jpg?w=1024';
    return List.generate(2, (index) {
      return Car('Ferrari - ${index + 1}', imgUrl2);
    });
  }
}
