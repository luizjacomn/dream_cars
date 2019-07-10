import 'dart:io';

import 'package:dream_cars/src/model/car.dart';
import 'package:dream_cars/src/services/blocs/car_bloc.dart';
import 'package:dream_cars/src/widgets/cars_list_view.dart';
import 'package:flutter/material.dart';

class CarsPage extends StatefulWidget {
  final String type;

  const CarsPage({this.type});

  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage>
    with AutomaticKeepAliveClientMixin<CarsPage> {
  final _bloc = CarBloc();

  String get type => widget.type;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _bloc.fetch(type);
  }

  Future<void> _onRefresh() {
    return _bloc.fetch(type);
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<List<Car>>(
          stream: _bloc.outCars,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CarsListView(snapshot.data);
            } else if (snapshot.hasError) {
              final error = snapshot.error;
              return ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Center(
                    child: Text(
                      error is SocketException
                          ? 'No network connection'
                          : 'Error',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
