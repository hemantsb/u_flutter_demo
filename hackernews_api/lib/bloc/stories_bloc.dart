import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../model/item.dart';
import 'dart:async';

class StoriesBloc {
  final _topIds = PublishSubject<List<int>>();
  final _repository = Repository();
  final _itemsOutput = BehaviorSubject<Map<int, Future<Item>>>();
  final _itemFetcher = PublishSubject<int>();

  StoriesBloc() {
    _itemFetcher.stream.transform(_itemTransformer()).pipe(_itemsOutput);
  }

  //Getters for stream
  Observable<List<int>> get topIds => _topIds.stream;

  Observable<Map<int, Future<Item>>> get items => _itemsOutput.stream;

  Function(int) get fetchItem => _itemFetcher.sink.add;

  fetchTopIds() async {
    final ids = await _repository.fetchTopItems();
    _topIds.sink.add(ids);
  }

  _itemTransformer() {
    return ScanStreamTransformer((Map<int, Future<Item>> cache, int id, index) {
      print("+$index");
      cache[id] = _repository.fetchItemWithId(id);
      return cache;
    }, <int, Future<Item>>{});
  }

  dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemFetcher.close();
  }
}
