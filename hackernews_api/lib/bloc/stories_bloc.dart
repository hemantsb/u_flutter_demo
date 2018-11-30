import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _topIds = PublishSubject<List<int>>();
  final _repository = Repository();

  //Getters for stream
  Observable<List<int>> get topIds => _topIds.stream;

  fetchTopIds() async {
    final ids = await _repository.fetchTopItems();
    _topIds.sink.add(ids);
  }

  dispose() {
    _topIds.close();
  }
}
