import 'package:tiempo_tech/data/model/nasa_result_model.dart';

abstract class DatabaseRepository {
  Future<void> init(int? version, List<String> migrations);

  //Items
  Future<List<Item>?> getItems();
  Future<Item?> getItemByTitle(String title);
  Future<void> deleteItem(String title);
  Future<void> insertItem(Item item);
}
