import 'package:dream_cars/src/db/car_db.dart';
import 'package:dream_cars/src/model/car.dart';
import 'package:dream_cars/src/widgets/cars_list_view.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<List<Car>> future = CarDB.getInstance().getAll();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<List<Car>>(
        future: future,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(
                child: Text(
              'Erro ao buscar dados.',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
              ),
            ));
          if (snapshot.hasData) {
            return CarsListView(snapshot.data);
          }
        },
      ),
    );
  }
}
