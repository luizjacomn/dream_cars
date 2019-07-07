import 'package:dream_cars/src/model/car.dart';
import 'package:dream_cars/src/utils/prefs.dart';
import 'package:dream_cars/src/widgets/cars_list_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    tabController = TabController(length: 3, vsync: this);

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
        title: Text('Cars'),
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(text: 'Classics', icon: Icon(Icons.directions_car)),
            Tab(text: 'Sports', icon: Icon(Icons.directions_car)),
            Tab(text: 'Luxs', icon: Icon(Icons.directions_car)),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          CarsListView(type: CarType.classics),
          CarsListView(type: CarType.sports),
          CarsListView(type: CarType.luxs),
        ],
      ),
    );
  }
}
