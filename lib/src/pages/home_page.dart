import 'package:dream_cars/src/services/cars_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _listView(),
      ),
    );
  }

  _listView() {
    final cars = CarsService.getCars();
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 250,
          child: Card(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: Image.network(cars[index].imgUrl),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        cars[index].name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                ButtonTheme.bar(
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('BUY TICKETS'),
                        onPressed: () {/* ... */},
                      ),
                      FlatButton(
                        child: const Text('LISTEN'),
                        onPressed: () {/* ... */},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
