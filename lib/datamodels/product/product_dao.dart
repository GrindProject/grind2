import 'package:automated_inventory/datamodels/product/product_datamodel.dart';
import 'package:automated_inventory/framework/dao_faunadb.dart';

class ProductDao extends DaoFaunaDB<ProductDataModel> {
  @override
  String getCollectionName() {
    return "products";
  }

  @override
  ProductDataModel createModelFromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      id: json['id'],
      description: json['description'],
      expirationDate: json['expirationDate'],
      measure: json['measure'],
    );
  }
}
