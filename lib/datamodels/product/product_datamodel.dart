import 'package:automated_inventory/framework/datamodel.dart';

class ProductDataModel extends DataModel {
  final String description;

  final String expirationDate;

  final String measure;

  ProductDataModel(String id, {required this.description, required this.expirationDate, required this.measure}) : super(id);

  @override
  Map<String, dynamic> toJson() {
    return {
      'object': {
        'data': {
          'description': this.description,
          'expirationDate': this.expirationDate,
          'measure': this.measure,
        }
      }
    };
  }
}
