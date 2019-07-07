import 'package:dream_cars/src/model/car.dart';
import 'package:dream_cars/src/pages/car_form_page.dart';
import 'package:dream_cars/src/pages/cars_page.dart';
import 'package:dream_cars/src/pages/favorites_page.dart';
import 'package:dream_cars/src/utils/nav.dart';
import 'package:dream_cars/src/utils/prefs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);

    Prefs.getInt('tabIndex').then((index) {
      tabController.index = index;
    });

    tabController.addListener(() {
      Prefs.setInt('tabIndex', tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Dream Cars'),
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(text: 'Classics', icon: Icon(Icons.directions_car)),
            Tab(text: 'Sports', icon: Icon(Icons.directions_car)),
            Tab(text: 'Luxs', icon: Icon(Icons.directions_car)),
            Tab(text: 'Favorites', icon: Icon(Icons.favorite)),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          CarsPage(type: CarType.classics),
          CarsPage(type: CarType.sports),
          CarsPage(type: CarType.luxs),
          FavoritesPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'pick-img',
        child: Icon(Icons.add),
        onPressed: () {
          push(context, CarFormPage());
        },
      ),
    );
  }
}
