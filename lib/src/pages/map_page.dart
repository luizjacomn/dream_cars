import 'package:dream_cars/src/model/car.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  final Car car;
  MapPage(this.car);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: car.latlng,
          zoom: 17,
        ),
        markers: Set.of(_getMarkers()),
      ),
    );
  }

  List<Marker> _getMarkers() {
    return [
      Marker(
        markerId: MarkerId('1'),
        position: car.latlng,
        infoWindow: InfoWindow(
          title: car.name,
          snippet: '${car.name}\'s Factory',
          onTap: () {},
        ),
      )
    ];
  }
}
