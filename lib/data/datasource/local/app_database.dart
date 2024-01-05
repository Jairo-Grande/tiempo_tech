import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:path/path.dart';
import 'package:synchronized/synchronized.dart';
import 'package:tiempo_tech/data/model/nasa_result_model.dart';
import 'package:tiempo_tech/utils/constants.dart';

part '../local/dao/item_nasa_dao.dart';

class AppDatabase {
  static var lock = Lock();
  static AppDatabase? _instance;
  static BriteDatabase? _streamDatabase;
  Database? _database;

  Future<AppDatabase?> getInstance() async {
    _instance ??= AppDatabase();
    _database ??= await database(1, null);
    return _instance;
  }

  Future<Database> _initDatabase(int? version, List<String>? migrations) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, Strings.dataBaseName);

    return await openDatabase(
      path,
      version: version,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE items(
        title TEXT PRIMARY KEY,
        href TEXT)
        ''');

        await db.execute('''
       CREATE TABLE data (
        id INTEGER PRIMARY KEY,
        center TEXT,
        title TEXT,
        keywords TEXT,
        nasa_id TEXT,
        date_created TEXT,
        media_type TEXT,
        description_508 TEXT,
        description TEXT,
        secondary_creator TEXT,
        photographer TEXT,
        location TEXT,
        album TEXT,
        FOREIGN KEY (title) REFERENCES items (title) ON DELETE CASCADE
)
        ''');

        await db.execute('''
          CREATE TABLE item_links (
            id INTEGER PRIMARY KEY,
            href TEXT,
            rel TEXT,
            render TEXT,
            title TEXT,
            FOREIGN KEY (title) REFERENCES items (title) ON DELETE CASCADE
)
        ''');

        if (migrations != null) {
          //INCLUDE HERE CODE TO IMPLEMENT MIGRATIONS IN DATABASE.
        }
      },
    );
  }

  Future<Database?> database(int? version, List<String>? migrations) async {
    if (_database != null) return _database;
    await lock.synchronized(() async {
      if (_database == null) {
        _database = await _initDatabase(version, migrations);
        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database;
  }

  Future<BriteDatabase?> get streamDatabase async {
    await database(null, null);
    return _streamDatabase;
  }

  //INSERT METHOD
  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await _instance?.streamDatabase;
    return db!.insert(table, row);
  }

  //UPDATE METHOD
  Future<int> update(
      String table, Map<String, dynamic> value, String columnId, int id) async {
    final db = await _instance?.streamDatabase;
    return db!.update(table, value, where: '$columnId = ?', whereArgs: [id]);
  }

  //DELETE METHOD
  Future<void> delete(String table, String columnId, String id) async {
    final db = await _instance?.streamDatabase;
    await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  ItemDao get itemNasaDao => ItemDao(_instance!);
}
