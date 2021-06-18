import 'businessmodel.dart';

abstract class Provider<BM extends BusinessModel> {
  Future<BM?> get(String id);

  Future<List<BM>> getAll();

  Future<bool> put(BM businessModel);
}
