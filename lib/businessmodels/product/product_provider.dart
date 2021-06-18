import 'package:automated_inventory/businessmodels/product/product_businessmodel.dart';
import 'package:automated_inventory/datamodels/product/product_dao.dart';
import 'package:automated_inventory/datamodels/product/product_datamodel.dart';
import 'package:automated_inventory/framework/provider.dart';

class ProductProvider extends Provider<ProductBusinessModel> {
  ProductDao _productDao = ProductDao();

  @override
  Future<ProductBusinessModel?> get(String id) async {
    ProductDataModel? dataModel = await _productDao.get(id);
    if (dataModel == null) return null;
    return _getBusinessModelFromDataModel(dataModel);
  }

  @override
  Future<List<ProductBusinessModel>> getAll() async {
    List<ProductBusinessModel> businessModels = List.empty(growable: true);
    List<ProductDataModel> dataModels = await _productDao.getAll();
    dataModels.forEach((dataModel) {
      businessModels.add(_getBusinessModelFromDataModel(dataModel));
    });
    return businessModels;
  }

  @override
  Future<bool> put(ProductBusinessModel businessModel) async {
    ProductDataModel dataModel = _getDataModelFromBusinessModel(businessModel);
    return _productDao.put(dataModel);
  }

  /// adapters

  ProductBusinessModel _getBusinessModelFromDataModel(ProductDataModel dataModel) {
    return ProductBusinessModel(
      id: dataModel.id,
      description: dataModel.description,
      expirationDate: dataModel.expirationDate,
      measure: dataModel.measure,
    );
  }

  ProductDataModel _getDataModelFromBusinessModel(ProductBusinessModel businessModel) {
    return ProductDataModel(
      id: businessModel.id,
      description: businessModel.description,
      expirationDate: businessModel.expirationDate,
      measure: businessModel.measure,
    );
  }
}
