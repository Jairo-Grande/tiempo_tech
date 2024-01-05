part of '../app_database.dart';

class ItemDao {
  final AppDatabase _appDatabase;
  ItemDao(this._appDatabase);

  Future<void> insertItem(Item item) async {
    _appDatabase
        .insert('items', {"href": item.href, "title": item.data![0].title});

    for (Datum datum in item.data ?? []) {
      await insertDatum(datum, item.data![0].title!);
    }

    for (ItemLink link in item.links ?? []) {
      await insertItemLink(link, item.data![0].title!);
    }
  }

  Future<void> deleteItem(String title) {
    return _appDatabase.delete('items', 'title', title);
  }

  Future<List<Item>?> getItems() async {
    final db = await _appDatabase.streamDatabase;
    final List<Map<String, dynamic>> itemMapList = await db!.query('items');

    if (itemMapList.isNotEmpty) {
      final List<Item> items = [];

      for (final Map<String, dynamic> itemMap in itemMapList) {
        final List<Datum> data = await getDataForItem(itemMap['title']);
        final List<ItemLink> links =
            await getItemLinksForItem(itemMap['title']);

        final Item item = Item.fromJson({
          "title": itemMap['title'],
          "href": itemMap['href'],
          "data": data.map((datum) => datum.toJson()).toList(),
          "links": links.map((link) => link.toJson()).toList(),
        });

        items.add(item);
      }

      return items;
    } else {
      return null;
    }
  }

  Future<void> insertDatum(Datum datum, String itemTitle) async {
    await _appDatabase.insert('data', {
      ...datum.toJson(),
      'title': itemTitle,
    });
  }

  Future<void> insertItemLink(ItemLink link, String itemTitle) async {
    await _appDatabase.insert('item_links', {
      ...link.toJson(),
      'title': itemTitle,
    });
  }

  Future<Item?> getItemByTitle(String title) async {
    final db = await _appDatabase.streamDatabase;
    final List<Map<String, dynamic>> itemMapList = await db!.query(
      'items',
      where: 'title = ?',
      whereArgs: [title],
    );

    if (itemMapList.isNotEmpty) {
      final Map<String, dynamic> itemMap = itemMapList.first;
      final List<Datum> data = await getDataForItem(title);
      final List<ItemLink> links = await getItemLinksForItem(title);

      final Item item = Item.fromJson({
        "title": itemMap['title'],
        "href": itemMap['href'],
        "data": data.map((datum) => datum.toJson()).toList(),
        "links": links.map((link) => link.toJson()).toList(),
      });

      return item;
    } else {
      return null;
    }
  }

  Future<List<Datum>> getDataForItem(String title) async {
    final db = await _appDatabase.streamDatabase;
    List<Map<String, dynamic>> dataMapList = await db!.query(
      'data',
      where: 'title = ?',
      whereArgs: [title],
    );

    List<Map<String, dynamic>> newDataMapList = dataMapList.map((dataMap) {
      String? existingKeywords = dataMap['keywords'];
      List<String>? updatedKeywords;

      if (existingKeywords != null) {
        updatedKeywords = [existingKeywords];
      } else {
        updatedKeywords = null;
      }

      String? existingAlbum = dataMap['album'];
      List<String>? updatedAlbum;

      if (existingAlbum != null) {
        updatedAlbum = [existingAlbum];
      } else {
        updatedAlbum = null;
      }

      return {
        ...dataMap,
        'keywords': updatedKeywords,
        'album': updatedAlbum,
      };
    }).toList();

    return newDataMapList.map((dataMap) => Datum.fromJson(dataMap)).toList();
  }

  Future<List<ItemLink>> getItemLinksForItem(String title) async {
    final db = await _appDatabase.streamDatabase;
    final List<Map<String, dynamic>> linksMapList = await db!.query(
      'item_links',
      where: 'title = ?',
      whereArgs: [title],
    );
    return linksMapList.map((linkMap) => ItemLink.fromJson(linkMap)).toList();
  }
}
