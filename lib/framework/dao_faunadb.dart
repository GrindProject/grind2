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

  getQueryForAllRecords();

  Future<DM?> get(String id) async {
    final query = Paginate(Match(Index("product_by_id")));
    final result = await _client.query(query);
    print(result);
    _client.close();
    return null;
  }

  Future<List<DM>> getAll() async {
    List<DM> list = List.empty(growable: true);
    final query = getQueryForAllRecords();
    final result = await _client.query(query);
    result.asMap().values.forEach((element) {
      (element as Map<String, dynamic>).values.forEach((element2) {
        (element2 as List<dynamic>).forEach((json) {
          list.add(createModelFromJson(json));
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
