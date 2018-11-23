import 'word.dart';
import 'language.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

class Api {
  Map<String, PublishSubject> _observables;
  Observable _wordsObservable;

  Api() {
    _buildObservables();
    _wordsObservable = Observable.merge(_observables.values).scan(
        (accumulator, list, i) => accumulator..addAll(list),
        []).asBroadcastStream();
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

  PublishSubject _buildObservableForLanguage(String lang) {
    return PublishSubject();
  }

  Future<void> searchForWord(String query) async {
    // _wordsObservable.drain();
    await _addWordsToStreams(query);
  }

  Future<void> _addWordsToStreams(String query) async {
    _addRomanianWords(query);
    _addEnglishWords(query);
  }

  Future<void> _addEnglishWords(String query) async {
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

  Future<void> _addRomanianWords(String query) async {
    if (query == '') return;
    await Future.delayed(Duration(milliseconds: 500));
    _observables['Romanian'].add(
      [
        Word(
          name: 'Romanian',
          definitions: {},
          isFavorite: false,
          language: languages['Romanian'],
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
  Observable get wordsStream => _wordsObservable;
}
