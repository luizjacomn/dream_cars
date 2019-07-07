import 'package:dream_cars/src/model/car.dart';
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
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<List<Car>>(
        future: CarsService.getCars(widget.type),
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
