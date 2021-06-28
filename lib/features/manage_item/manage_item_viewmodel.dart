

import 'package:automated_inventory/framework/codemessage.dart';
import 'package:automated_inventory/framework/model.dart';
import 'package:automated_inventory/framework/viewmodel.dart';
import 'package:faunadb_http/query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageItemViewModel extends ViewModel {
  final String id;

  ManageItemViewModel(this.id);

  TextEditingController descriptionController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  //var FutureDate = new DateTime(DateTime.now().year +5, DateTime.now().month, DateTime.now().day);
  TextEditingController measureController = TextEditingController();
  TextEditingController upcNumberController = TextEditingController();

  String screenTitle = "";

  CodeMessage? responseToSaveItem;
}

class ManageItemViewModelItemModel extends Model {
  final String id;
  final String description;
  final String expirationDate;
  final String measure;

  ManageItemViewModelItemModel({required this.id, required this.description, required this.expirationDate, required this.measure});
}
