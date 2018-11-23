import 'package:rxdart/rxdart.dart';
import '../models/word.dart';
import '../models/api.dart';
import 'dart:async';

class DictionaryBloc {
  final Api api = Api();
  ReplaySubject<String> _query = ReplaySubject<String>();
  Stream _results = Stream.empty();
  DictionaryBloc() {
    _results = api.wordsStream;
    _query.distinct().listen(api.searchForWord);
  }

  void dispose() {
    _query.close();
  }

  void handleSearch(String query) async {
    _query.sink.add(query);
  }

  Stream<dynamic> get results => _results;
}
