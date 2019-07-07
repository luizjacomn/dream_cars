import 'dart:io';

import 'package:dream_cars/src/model/car.dart';
import 'package:dream_cars/src/services/cars_service.dart';
import 'package:dream_cars/src/utils/alerts.dart';
import 'package:dream_cars/src/utils/nav.dart';
import 'package:dream_cars/src/widgets/image_source_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarFormPage extends StatefulWidget {
  final Car car;

  CarFormPage({this.car});

  @override
  State<StatefulWidget> createState() => _CarFormPageState();
}

class _CarFormPageState extends State<CarFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  int _radioIndex = 0;

  var _showProgress = false;

  File imageFile;

  Car get car => widget.car;

  String _validateNome(String value) {
    if (value.isEmpty) {
      return 'The name field is required';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    if (car != null) {
      _nameController.text = car.name;
      _descController.text = car.desc;
      _radioIndex = getTypeInt(car);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          car != null ? car.name : "New Car",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: _form(),
      ),
    );
  }

  _form() {
    return Form(
      key: this._formKey,
      child: ListView(
        children: <Widget>[
          _headerImage(),
          Text(
            "Click on the picture to pick a new image",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Divider(),
          Text(
            "Type",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
          ),
          _radioType(),
          Divider(),
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            validator: _validateNome,
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Name',
            ),
          ),
          TextFormField(
            controller: _descController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
            decoration: InputDecoration(
              hintText: '',
              labelText: 'Description',
            ),
          ),
          Hero(
            tag: 'pick-img',
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                child: _showProgress
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        "Save".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                onPressed: () {
                  _onClickSave(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _headerImage() {
    if (imageFile != null) {
      return InkWell(
        onTap: _onClickImage,
        child: Image.file(
          imageFile,
          height: 150,
        ),
      );
    } else {
      return InkWell(
        onTap: _onClickImage,
        child: car != null && car.imgUrl != null
            ? Hero(tag: 'img-${car.id}', child: Image.network(car.imgUrl))
            : Icon(
                Icons.camera_enhance,
                size: 100,
                color: Colors.grey,
              ),
      );
    }
  }

  _radioType() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _typeTile(context, 'Classics', 0),
          _typeTile(context, 'Sports', 1),
          _typeTile(context, 'Luxs', 2),
        ],
      ),
    );
  }

  _typeTile(context, String label, int value) {
    return Row(
      children: <Widget>[
        Radio(
          value: value,
          groupValue: _radioIndex,
          onChanged: _onClickType,
        ),
        Text(
          label,
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
        ),
      ],
    );
  }

  void _onClickType(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  getTypeInt(Car car) {
    switch (car.type) {
      case CarType.classics:
        return 0;
      case CarType.sports:
        return 1;
      default:
        return 2;
    }
  }

  String _getType() {
    switch (_radioIndex) {
      case 0:
        return CarType.classics;
      case 1:
        return CarType.sports;
      default:
        return CarType.luxs;
    }
  }

  _onClickSave(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    var c = car ?? Car();
    c.name = _nameController.text;
    c.desc = _descController.text;
    c.type = _getType();

    setState(() {
      _showProgress = true;
    });

    final response = await CarsService.save(c);
    if (response.isOk()) {
      alert(context, "Car saved", response.message,
          callback: () => pop(context));
    } else {
      alert(context, "Error", response.message);
    }

    setState(() {
      _showProgress = false;
    });
  }

  void _onClickImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ImageSourceSheet(
            onImageSelected: (img) {
              setState(() {
                imageFile = img;
              });
              Navigator.of(context).pop();
            },
          ),
    );
  }
}
