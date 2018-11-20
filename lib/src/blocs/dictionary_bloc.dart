import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../models/word.dart';

class DictionaryBloc {
  ReplaySubject<String> _query = ReplaySubject<String>();
  Stream <List<Word>> _results = Stream.empty();

  void dispose() {
    _query.close();
  }

  void handleSearch(String request) {
    _query.add(request);
  }
}
