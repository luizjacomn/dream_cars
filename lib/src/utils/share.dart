import 'dart:io';
import 'dart:typed_data';

import 'package:dream_cars/src/model/car.dart';
import 'package:flutter/foundation.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

share(Car car) async {
  var request = await HttpClient().getUrl(Uri.parse(car.imgUrl));
  var response = await request.close();
  Uint8List bytes = await consolidateHttpClientResponseBytes(response);
  await Share.file('Share with', '${car.name}.png', bytes, 'image/png');
}
