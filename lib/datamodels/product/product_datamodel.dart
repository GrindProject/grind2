import 'package:automated_inventory/framework/datamodel.dart';

class ProductDataModel extends DataModel {
  final String id;

  final String description;

  final String expirationDate;

  final String measure;

  ProductDataModel({required this.id, required this.description, required this.expirationDate, required this.measure});
}
