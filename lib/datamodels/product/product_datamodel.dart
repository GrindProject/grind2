import 'package:automated_inventory/framework/datamodel.dart';
import 'package:faunadb_http/query.dart';

class ProductDataModel extends DataModel {
  final String description;

  final String expirationDate;

  final String measure;

  final String upcNumber;

  ProductDataModel(String id, {required this.description, required this.expirationDate, required this.measure, required this.upcNumber}) : super(id);

  @override
  Map<String, dynamic> toJson() {
    return {
          'description': this.description,
          'expirationDate': this.expirationDate,
          'measure': this.measure,
          'upcNumber': this.upcNumber,
    };
  }
}
