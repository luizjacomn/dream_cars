import 'package:dream_cars/src/db/car_db.dart';
import 'package:dream_cars/src/model/car.dart';
import 'package:dream_cars/src/pages/car_form_page.dart';
import 'package:dream_cars/src/services/cars_service.dart';
import 'package:dream_cars/src/utils/alerts.dart';
import 'package:dream_cars/src/utils/nav.dart';
import 'package:flutter/material.dart';

class CarDetailsPage extends StatefulWidget {
  final Car car;

  const CarDetailsPage(this.car);

  _CarDetailsPageState createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  Car get car => widget.car;

  bool isFav = false;

  @override
  void initState() {
    super.initState();

    CarDB.getInstance().exists(car).then((exists) {
      if(exists) {
        setState(() {
        isFav = exists;
      });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (option) {
              _onClickOption(option);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
                PopupMenuItem(
                  child: Text('Share'),
                ),
              ];
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        Hero(
          tag: 'img-${car.id}',
          child: car.imgUrl == null || car.imgUrl.isEmpty
              ? Icon(
                  Icons.broken_image,
                  size: 100,
                  color: Colors.grey,
                )
              : Image.network(
                  car.imgUrl,
                  fit: BoxFit.cover,
                ),
        ),
        block1(),
        block2(),
      ],
    );
  }

  block1() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                car.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                car.type,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => _onFavClick(context, car),
          child: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            size: 36,
            color: isFav ? Colors.red : Colors.black,
          ),
        ),
        InkWell(
          child: Icon(
            Icons.share,
            size: 36,
          ),
        ),
      ],
    );
  }

  block2() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            car.desc,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          FutureBuilder<String>(
              future: CarsService.getLoremIpsum(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                }
                return Text(
                  snapshot.data,
                  textAlign: TextAlign.justify,
                );
              }),
        ],
      ),
    );
  }

  _onFavClick(BuildContext context, car) async {
    final db = CarDB.getInstance();

    bool exists = await db.exists(car);

    exists ? db.delete(car.id) : db.save(car);

    setState(() {
      isFav = !exists;
    });
  }

  void _onClickOption(String option) {
    switch (option) {
      case 'edit':
        push(context, CarFormPage(car: car));
        break;
      case 'delete':
        _deletar();
        break;
      default:
        break;
    }
  }

  Future _deletar() async {
    final response = await CarsService.delete(car);
    if (response.isOk()) {
      pop(context);
    } else {
      alert(context, "Error", response.message);
    }
  }
}
