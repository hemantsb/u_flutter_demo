import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../model/item.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<Item>>>();

  //Streams
  Observable<Map<int, Future<Item>>> get itemWithComment =>
      _commentsOutput.stream;

  //Sink
  Function(int) get fetchItemWithComment => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<Item>>>(
      (cache, int id, index) {
        print("transformer $id");
        cache[id] = _repository.fetchItemWithId(id);
        cache[id].then((Item item) {
          item.kids.forEach((kidId) => fetchItemWithComment(kidId));
        });

        return cache;
      },
      <int, Future<Item>>{},
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
