import 'package:flutter/foundation.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/db/database_helper.dart';
import 'package:flutter_base/entry/car.dart';
import 'dart:collection';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class DbProvider with ChangeNotifier {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Car> carList;

  UnmodifiableListView<Car> get allCars => UnmodifiableListView(carList);

  UnmodifiableListView<Car> get unStartedCars =>
      UnmodifiableListView(carList.where((car) => car.start == false));

  UnmodifiableListView<Car> get startedCars =>
      UnmodifiableListView(carList.where((car) => car.start == true));

  void getCarList() {
    final Future<Database> dbFuture = _databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Car>> carListFuture = _databaseHelper.getCarList();
      carListFuture.then((carList) {
        this.carList = carList;
        notifyListeners();
      });
    });
  }


  void addCar(Car car) async {
    int result;
    if (car.id != null) {
      result = await _databaseHelper.updateCar(car);
    } else {
      result = await _databaseHelper.insertCar(car);
    }
    if (result != 0) {
      print('Success');
    } else {
      print('Failed');
    }
    notifyListeners();
  }

  void startCar(BuildContext context, Car car) async {
    car.start = !car.start;
    int result = await _databaseHelper.updateCar(car);

    if (result != 0 && car.start == true) {
      _showSnackBar(context, '${car.brand}' +'  '+'${car.type}' + '      ' +'Start');
    }
    notifyListeners();
  }

  void deleteCar(BuildContext context, Car car) async {
    if (car.id == null) {
      _showSnackBar(context, 'No Car was deleted');
      return;
    }

    int result = await _databaseHelper.deleteCar(car.id);
    if (result != 0) {
      _showSnackBar(context, 'Car Deleted Successfully');
    } else {
      _showSnackBar(context, 'Error Occurred while deleting note');
    }
    notifyListeners();
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      duration: Duration(milliseconds: 500),
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
