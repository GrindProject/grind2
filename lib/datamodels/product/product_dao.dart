import 'package:automated_inventory/datamodels/product/product_datamodel.dart';
import 'package:automated_inventory/framework/dao_faunadb.dart';
import 'package:faunadb_http/query.dart';

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

  @override
  getQueryForAllRecords() {
    return Map_(
      Paginate(Match(Index('all_products'))),
      Lambda(
        'Ref',
        Let(
          {
            'Doc': Get(Var('Ref')),
          },
          Obj(
            {
              "id": Select(['ref', "id"], Var('Doc')),
              'description': Select(['data', 'description'], Var('Doc')),
              'measure': Select(['data', 'measure'], Var('Doc')),
              'expirationDate': Select(['data', 'expirationDate'], Var('Doc')),
              // 'measure': Select(['ref', 'measure'], Var('Doc')),
            },
          ),
        ),
      ),
    );
  }
}
