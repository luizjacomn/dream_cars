import 'dart:async';

import 'package:dream_cars/src/model/car.dart';
import 'package:dream_cars/src/services/blocs/car_bloc.dart';
import 'package:dream_cars/src/services/cars_service.dart';
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

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _bloc.fetch(widget.type);
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: StreamBuilder(
        stream: _bloc.outCars,
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
          return CarsListView(snapshot.data);
        },
      ),
    );
  }
}
