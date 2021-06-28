import 'package:automated_inventory/framework/codemessage.dart';
import 'package:automated_inventory/framework/model.dart';
import 'package:automated_inventory/framework/viewmodel.dart';
import 'package:faunadb_http/query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainInventoryViewModel extends ViewModel {
  final List<MainInventoryViewModelItemModel> cachedItems = List.empty(growable: true);
  final List<MainInventoryViewModelItemModel> items = List.empty(growable: true);

  CodeMessage? responseToDeleteItem;
}

class MainInventoryViewModelItemModel extends Model {
  final String id;
  final String name ;
  final String expirationDate;
  final String measure;
  final int qty;

  final Color color;

  MainInventoryViewModelItemModel(this.id, this.name, this.expirationDate, this.measure, this.color, this.qty);

  String toString() {
    return '$name $expirationDate $measure';
  }
}
