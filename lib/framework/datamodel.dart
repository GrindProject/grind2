import 'model.dart';

abstract class DataModel extends Model {
  final String id;

  DataModel(this.id);

  Map<String, dynamic> toJson();
}
