import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../model/item.dart';

final _root = "https://hacker-news.firebaseio.com/v0";

class ApiProvider {

  var client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get("$_root/v0/topstories.json");
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<Item> fetchItem(int id) async {
    final response = await client.get('$_root/v0/item/$id.json');
    final parsedJson = json.decode(response.body);
    return Item.fromJson(parsedJson);
  }
}
