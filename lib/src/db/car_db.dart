import 'dart:async';

import 'package:dream_cars/src/model/car.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CarDB {
  static final CarDB _instance = new CarDB.getInstance();

  factory CarDB() => _instance;

  CarDB.getInstance();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cars.db');
    print("db $path");

    // para testes vc pode deletar o banco
    //await deleteDatabase(path);

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db
        .execute('CREATE TABLE car(id INTEGER PRIMARY KEY, name TEXT, type TEXT'
            ', desc TEXT, imgUrl TEXT, urlVideo TEXT, lat TEXT, lng TEXT)');
  }

  Future<int> save(Car car) async {
    var dbClient = await db;
    final sql =
        'insert or replace into Car (id, name ,type ,desc ,imgUrl ,urlVideo ,lat ,lng ) VALUES '
        '(?, ?, ?, ?, ?, ?, ?, ?)';
    print(sql);
    var id = await dbClient.rawInsert(sql, [
      car.id,
      car.name,
      car.type,
      car.desc,
      car.imgUrl,
      car.urlVideo,
      car.latitude,
      car.longitude
    ]);
    print('id: $id');
    return id;
  }

  Future<List<Car>> getAll() async {
    final dbClient = await db;

    final mapCars = await dbClient.rawQuery('select * from Car');

    final cars = mapCars.map<Car>((json) => Car.fromJson(json)).toList();

    return cars;
  }

  Future<int> getCount() async {
    final dbClient = await db;
    final result = await dbClient.rawQuery('select count(*) from Car');
    return Sqflite.firstIntValue(result);
  }

  Future<Car> getById(int id) async {
    var dbClient = await db;
    final result =
        await dbClient.rawQuery('select * from Car where id = ?', [id]);

    if (result.length > 0) {
      return new Car.fromJson(result.first);
    }

    return null;
  }

  Future<bool> exists(Car car) async {
    Car c = await getById(car.id);
    var exists = c != null;
    return exists;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from Car where id = ?', [id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
