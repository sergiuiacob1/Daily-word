import './../models/word.dart';
import './apis/api_romanian_bloc.dart';
import './apis/api_english_bloc.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class InternetResultsBloc {
  BehaviorSubject _wordsStream = BehaviorSubject();
  List<Word> _myAccumulator = [];
  Map<String, dynamic> _apiLanguageBlocHandlers = {};
  bool _stillSearching = false;

  InternetResultsBloc() {
    _buildApiBlocHandlers();
    Observable.merge(
      _apiLanguageBlocHandlers.values.map((item) => item.resultsStream),
    ).scan((accumulator, word, i) => _mergeData(word), []).listen((onData) {
      _checkIfSearchIsComplete();
      _wordsStream.add(onData);
    });
  }

  void _checkIfSearchIsComplete() {
    for (var _apiBloc in _apiLanguageBlocHandlers.values)
      if (_apiBloc.isStillSearching) {
        _stillSearching = true;
        return;
      }
    _stillSearching = false;
  }

  void dispose() {
    _wordsStream.close();
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
    _stillSearching = true;
    _myAccumulator = [];
    for (var _apiBloc in _apiLanguageBlocHandlers.values) {
      _apiBloc.cancelExistingSearches();
      if (query == '') continue;
      if (_apiBloc.languageIsSelected == false) continue;
      _apiBloc.searchForWords(query);
    }
    if (query == '') _wordsStream.add(null);
  }

  /// This will automatically push the daily words into the [_wordsStream]
  void getDailyWords() async {
    for (var _apiBloc in _apiLanguageBlocHandlers.values) {
      if (_apiBloc.languageIsSelected == false) continue;
      _apiBloc.getDailyWord();
    }
  }

  /// It merges the Observables (one for each language) into one BehaviorSubject
  BehaviorSubject get wordsStream => _wordsStream;

  bool get isStillSearching => _stillSearching;
}
