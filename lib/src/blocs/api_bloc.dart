import './../models/word.dart';
import './apis/api_romanian_bloc.dart';
import './apis/api_english_bloc.dart';
import 'dart:async';

import 'package:rxdart/rxdart.dart';

class ApiBloc {
  BehaviorSubject _wordsObservable = BehaviorSubject(seedValue: []);
  List<Word> _myAccumulator = [];
  Map<String, dynamic> _apiLanguageBlocHandlers = {};

  ApiBloc() {
    _buildApiBlocHandlers();
    Observable.merge(
      _apiLanguageBlocHandlers.values.map((item) => item.observable),
    ).scan((accumulator, word, i) => _mergeData(word), []).listen((onData) {
      _wordsObservable.add(onData);
    });
  }

  void dispose() {
    _wordsObservable.close();
  }

  void _buildApiBlocHandlers() {
    _apiLanguageBlocHandlers['Romanian'] = ApiRomanianBloc();
    _apiLanguageBlocHandlers['English'] = ApiEnglishBloc();
  }

  /// Merge the data from different streams into a single array
  dynamic _mergeData(Word word) {
    if (word == null) return _myAccumulator;
    return _myAccumulator..add(word);
  }

  /// Search for a word in each language
  Future<void> searchForWord(String query) async {
    _myAccumulator = [];
    for (var _apiBloc in _apiLanguageBlocHandlers.values) {
      _apiBloc.cancelExistingSearch();
      if (_apiBloc.languageIsSelected == false) continue;
      _apiBloc.searchForWord(query);
    }
  }

  /// It merges the Observables (one for each language) into one BehaviorSubject
  BehaviorSubject get wordsStream => _wordsObservable;
}
