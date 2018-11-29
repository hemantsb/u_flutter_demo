import 'dart:async';
import 'db_provider.dart';
import 'api_provider.dart';
import '../model/item.dart';

class Repository {
  ApiProvider apiProvider = new ApiProvider();
  DbProvider dbProvider = new DbProvider();

  Future<List<int>> fetchTopItems() {
    return apiProvider.fetchTopIds();
  }

  Future<Item> fetchItemWithId(int itemId) async {
    var item = await dbProvider.fetchItem(itemId);
    if (item != null) {
      return item;
    }

    var apiItem = await apiProvider.fetchItem(itemId);
    dbProvider.addItem(apiItem);
    return apiItem;
  }
}
