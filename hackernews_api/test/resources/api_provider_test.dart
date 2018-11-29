import 'package:hackernews_api/resources/api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Fetch topIds and return list of ids ', () async {
    final newsApi = ApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final serverIds = await newsApi.fetchTopIds();
    expect(serverIds, [1, 2, 3, 4]);
  });

  test('Fetch item details', () async {
    final newsApi = ApiProvider();
    newsApi.client = MockClient((request) async {
      final resultMap = {'id': 123};
      return Response(json.encode(resultMap), 200);
    });

    final item = await newsApi.fetchItem(0999);
    expect(item.id, 123);
  });
}
