import 'dart:async';
import 'db_provider.dart';
import 'api_provider.dart';
import '../model/item.dart';

class Repository {
  List<Source> sourcelist = [dbProvider, ApiProvider()];
  List<Cache> caches = [dbProvider];

  Future<List<int>> fetchTopItems() {
    return sourcelist[1].fetchTopIds();
  }

  Future<Item> fetchItemWithId(int itemId) async {
    Item item;
    Source source;

    for (source in sourcelist) {
      item = await source.fetchItem(itemId);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      cache.addItem(item);
    }
    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();

  Future<Item> fetchItem(int itemId);
}

abstract class Cache {
  Future<int> addItem(Item item);
}
