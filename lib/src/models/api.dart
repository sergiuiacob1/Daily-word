import 'word.dart';
import 'language.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

class Api {
  Map<String, PublishSubject<List<Word>>> _observables;
  Observable<List<Word>> _wordsObservable;

  Api() {
    _buildObservables();
    _wordsObservable = Observable.merge(_observables.values)
        .scan((accumulator, list, i) => accumulator..addAll(list), [])
        .asBroadcastStream()
        .cast<List<Word>>();
  }

  void dispose() {
    for (var _item in _observables.values) _item.close();
  }

  /// Each language has an Observable that uses its own stream
  void _buildObservables() {
    _observables = {};
    for (String lang in languages.keys)
      _observables[lang] = _buildObservableForLanguage(lang);
  }

  PublishSubject<List<Word>> _buildObservableForLanguage(String lang) {
    return PublishSubject<List<Word>>();
  }

  Future<void> searchForWord(String query) async {
    // _wordsObservable.drain();
    _addWordsToStreams(query);
  }

  Future<void> _addWordsToStreams(String query) async {
    if (query == '') return;
    _observables['English'].add(
      [
        Word(
          name: 'English',
          definitions: {},
          isFavorite: false,
          language: languages['English'],
        ),
      ],
    );
  }

  bool languageIsActive(String lang) {
    // hardcoded for the moment
    if (lang == 'English' || lang == 'Romanian') return true;
    return false;
  }

  /// This will return an Observable with the words from all of the languages
  /// It merges the Observables (one for each language) into one
  Observable<List<Word>> get wordsStream {
    print('GET words observable');
    return _wordsObservable;
  }
}
