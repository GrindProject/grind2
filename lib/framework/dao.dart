import 'datamodel.dart';

abstract class Dao<DM extends DataModel> {
  Future<DM?> get(String id);

  Future<List<DM>> getAll();

  Future<bool> put(DM dataModel);
}

