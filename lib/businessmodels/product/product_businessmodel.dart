import 'package:automated_inventory/framework/businessmodel.dart';
import 'package:faunadb_http/query.dart';

class ProductBusinessModel extends BusinessModel {
  final String id;

  final String description;

  final String expirationDate;

  final String measure;

  final String upcNumber;

  ProductBusinessModel({required this.id, required this.description, required this.expirationDate, required this.measure, required this.upcNumber});
}
