import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../models/word.dart';
import '../models/api.dart';
import '../models/language.dart';

class DictionaryBloc {
  final Api api = Api();
  ReplaySubject<String> _query = ReplaySubject<String>();
  Stream<List<Word>> _results = Stream.empty();

  DictionaryBloc() {
    _results = _query.distinct().asyncMap(api.getWords).asBroadcastStream();
  }

  void dispose() {
    _query.close();
  }

  void handleSearch(String request) {
    print('searching $request');
    _query.sink.add(request);
  }

  Stream<List<Word>> get results => _results;
}
