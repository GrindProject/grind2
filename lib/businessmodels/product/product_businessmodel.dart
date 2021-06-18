import 'package:automated_inventory/framework/businessmodel.dart';

class ProductBusinessModel extends BusinessModel {
  final String id;

  final String description;

  final String expirationDate;

  final String measure;

  ProductBusinessModel({required this.id, required this.description, required this.expirationDate, required this.measure});
}
