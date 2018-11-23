import 'word.dart';
import 'language.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

class Api {
  Map<String, StreamController<List<Word>>> _streams;
  List<Observable<List<Word>>> _observables;

  Api() {
    _buildStreams();
    _buildObservables();
  }

  /// Each language will have a different StreamController, corresponding to a different api
  void _buildStreams() {
    _streams = {};
    for (String lang in languages.keys) _streams[lang] = StreamController();
  }

  /// Each language has an Observable that uses its own stream
  List<Observable> _buildObservables() {
    List<Observable> _rez = [];
    for (String lang in languages.keys)
      if (languageIsActive(lang))
        _rez.add(
          _buildObservableForLanguage(lang),
        );

    return _rez;
  }

  /// This will return an Observable with the words from all of the languages
  /// It merges the Observables (one for each language) into one
  Observable<List<Word>> getWords(String query) {
    _addWordsToStreams(query);
    return Observable.merge(_observables)
        .scan((accumulator, list, i) => accumulator..addAll(list), []);
  }

  void _addWordsToStreams(String query) async {
    if (query == '') return;
    _streams['English'].sink.add(
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

  Observable<List<Word>> _buildObservableForLanguage(String lang) {
    return Observable(_streams[lang].stream);
  }

  bool languageIsActive(String lang) {
    //hardcoded for the moment
    if (lang == 'English' || lang == 'Romanian') return true;
    return false;
  }

  Future<List<Word>> getWordsForLanguage(String lang, String query) {
    switch (lang) {
      case 'English':
        return (getWordsEnglish(query));
      default:
      // return [];
    }
  }

  Future<List<Word>> getWordsEnglish(String query) async {
    final url = 'https://en.wiktionary.org/api/rest_v1/page/definition/$query';
    final response = await http.get(url);
//     if (response.statusCode != 200) {
//       return {};
//     }
  }
}
