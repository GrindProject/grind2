import 'package:automated_inventory/datamodels/nutritionix_item/nutritionix_item_datamodel.dart';
import 'package:automated_inventory/datamodels/product/product_datamodel.dart';
import 'package:automated_inventory/framework/codemessage.dart';
import 'package:automated_inventory/framework/dao_faunadb.dart';
import 'package:automated_inventory/framework/dao_firebasedb.dart';
import 'package:automated_inventory/framework/dao_nutritionix.dart';

class NutritionixItemDao extends DaoNutritionix<NutritionixItemDataModel> {


  @override
  NutritionixItemDataModel createModelFromJson(String id, Map<String, dynamic> json) {
    return NutritionixItemDataModel(
      id,
      item_name: json['item_name'],
      brand_name: json['brand_name'],
      servings_per_container: json['servings_per_container'],
      serving_size_qty: json['serving_size_qty'],
      serving_size_unit: json['serving_size_unit'],
    );
  }




}
