import 'package:hackernews_api/resources/repository.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../model/item.dart';
import 'dart:async';

final _root = "https://hacker-news.firebaseio.com/v0";

class ApiProvider implements Source{

  var client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get("$_root/topstories.json");
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<Item> fetchItem(int id) async {
    final response = await client.get('$_root/item/$id.json');
    final parsedJson = json.decode(response.body);
    return Item.fromJson(parsedJson);
  }
}
