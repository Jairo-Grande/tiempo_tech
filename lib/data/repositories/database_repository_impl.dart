import 'package:tiempo_tech/data/datasource/local/app_database.dart';
import 'package:tiempo_tech/data/model/nasa_result_model.dart';
import 'package:tiempo_tech/domain/repositories/database_repository.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final AppDatabase _appDatabase;
  DatabaseRepositoryImpl(this._appDatabase);

  @override
  Future<List<Item>?> getItems() async {
    return await _appDatabase.itemNasaDao.getItems();
  }

  @override
  Future<void> init(int? version, List<String> migrations) async {
    await _appDatabase.database(version, migrations);
    return Future.value();
  }

  @override
  Future<void> deleteItem(String title) async {
    await _appDatabase.itemNasaDao.deleteItem(title);
  }

  @override
  Future<void> insertItem(Item item) async {
    await _appDatabase.itemNasaDao.insertItem(item);
  }

  @override
  Future<Item?> getItemByTitle(String title) async {
    return await _appDatabase.itemNasaDao.getItemByTitle(title);
  }
}
