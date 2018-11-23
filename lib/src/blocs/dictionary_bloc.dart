import 'package:rxdart/rxdart.dart';
import '../models/word.dart';
import '../models/api.dart';
import 'dart:async';

class DictionaryBloc {
  final Api api = Api();
  ReplaySubject<String> _query = ReplaySubject<String>();
  StreamController<List<Word>> _results = StreamController();

  DictionaryBloc() {
    api.wordsStream.listen((onData) {
      _results.sink.add(onData);
    });
    _query.distinct().listen(api.searchForWord);
  }

  void dispose() {
    _query.close();
    _results.close();
  }

  void handleSearch(String query) {
    print('Searching: $query');
    _query.sink.add(query);
  }

  Stream<List<Word>> get results => _results.stream;
}
