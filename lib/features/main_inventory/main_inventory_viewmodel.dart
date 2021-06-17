import 'package:automated_inventory/framework/viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainInventoryViewModel extends ViewModel {

  bool flgProcesing = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController measureController = TextEditingController();
  TextEditingController addedOnController = TextEditingController();

  final List<String> names = List.empty(growable: true);
  final List<String> expiration = List.empty(growable: true);
  final List<String> measure = List.empty(growable: true);
  final List<String> addedOn = List.empty(growable: true);
  final List<int> msgCount = List.empty(growable: true);

  final Color nameColor = Colors.blue;
}