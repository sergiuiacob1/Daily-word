import 'package:rxdart/rxdart.dart';
import 'api_bloc.dart';
import 'dart:async';

class DictionaryBloc {
  final ApiBloc apiBloc = ApiBloc();
  ReplaySubject<String> _query = ReplaySubject<String>();
  Stream _results = Stream.empty();
  DictionaryBloc() {
    _results = apiBloc.wordsStream;
    _query.distinct().listen(apiBloc.searchForWord);
  }

  void dispose() {
    _query.close();
  }

  void handleSearch(String query) async {
    _query.sink.add(query);
  }

  Stream<dynamic> get results => _results;
}
