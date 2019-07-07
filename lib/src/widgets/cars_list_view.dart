import 'package:dream_cars/src/model/car.dart';
import 'package:dream_cars/src/pages/car_details_page.dart';
import 'package:dream_cars/src/utils/nav.dart';
import 'package:flutter/material.dart';

class CarsListView extends StatelessWidget {
final List<Car> cars;

  const CarsListView(this.cars);

  @override
  Widget build(BuildContext context) {
    return _listView(cars);
  }

  _listView(List<Car> cars) {
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: InkWell(
            onTap: () => _onCarClick(context, cars[index]),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Hero(
                        tag: 'img-${cars[index].id}',
                        child: cars[index].imgUrl == null ||
                                cars[index].imgUrl.isEmpty
                            ? Icon(
                                Icons.broken_image,
                                size: 100,
                                color: Colors.grey,
                              )
                            : Image.network(
                                cars[index].imgUrl,
                              ),
                      ),
                    ),
                    Text(
                      cars[index].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      cars[index].desc,
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('DETAILS'),
                            onPressed: () => _onCarClick(context, cars[index]),
                          ),
                          FlatButton(
                            child: const Text('SHARE'),
                            onPressed: () {/* ... */},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onCarClick(BuildContext context, Car car) {
    push(context, CarDetailsPage(car));
  }
}