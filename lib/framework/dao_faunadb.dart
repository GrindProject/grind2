import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';

import 'dao.dart';
import 'datamodel.dart';

final config = FaunaConfig.build(
  secret: 'fnAEL79bh6ACAA1nfM7Oqm6uczZQbYmdOyzf3RTD',
);

abstract class DaoFaunaDB<DM extends DataModel> extends Dao<DM> {
  final _client = FaunaClient(config);

  String getCollectionName();

  DM createModelFromJson(Map<String, dynamic> json);

  Future<DM?> get(String id) async {
    final query = Paginate(Match(Index("product_by_id")));
    final result = await _client.query(query);
    print(result);
    _client.close();
    return null;
  }

  Future<List<DM>> getAll() async {
    List<DM> list = List.empty(growable: true);
    final query = Map_(Paginate(Match(Index('all_products'))), Lambda('Ref', Let({'Doc': Get(Var('Ref'))}, Var('Doc'))));
    final result = await _client.query(query);
    result.asMap().values.forEach((element) {
      (element as Map<String, dynamic>).values.forEach((element2) {
        (element2 as List<dynamic>).forEach((element3) {
          list.add(createModelFromJson(element3['data']));
        });
      });
    });
    _client.close();
    return list;
  }

  Future<bool> put(DM dataModel) async {
    return false;
  }
}
