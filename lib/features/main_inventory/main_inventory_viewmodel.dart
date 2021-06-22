import 'package:automated_inventory/framework/model.dart';
import 'package:automated_inventory/framework/viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainInventoryViewModel extends ViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController measureController = TextEditingController();
  Color colorController = Colors.yellow;

  final List<MainInventoryViewModelItemModel> cachedItems = List.empty(growable: true);
  final List<MainInventoryViewModelItemModel> items = List.empty(growable: true);
}

class MainInventoryViewModelItemModel extends Model {
  final String id;
  final String name;
  final String expirationDate;
  final String measure;
  final int qty;

  final Color color;

  MainInventoryViewModelItemModel(this.id, this.name, this.expirationDate, this.measure, this.color, this.qty);

  String toString() {
    return '$name $expirationDate $measure';
  }
}
