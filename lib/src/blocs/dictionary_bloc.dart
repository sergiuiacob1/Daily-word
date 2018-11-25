import 'package:rxdart/rxdart.dart';
import 'api_bloc.dart';
import 'dart:async';
import './words_storage_bloc.dart';

class DictionaryBloc {
  final ApiBloc apiBloc = ApiBloc();
  ReplaySubject<String> _query = ReplaySubject<String>();
  DictionaryBloc() {
    _query.distinct().listen(apiBloc.searchForWord);
  }

  void dispose() {
    _query.close();
  }

  void handleSearch(String query) async {
    _query.sink.add(query);
  }

  Observable get results => apiBloc.wordsStream;
}
