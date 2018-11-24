import './../models/word.dart';
import './../models/language.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'dart:convert';

class ApiRomanianBloc {
  PublishSubject _observable = PublishSubject();
  CancelableCompleter _webSearch;

  final url = "https://ro.wiktionary.org/wiki/{1}?printable=yes";

  void dispose() {
    _observable.close();
  }

  void cancelExistingSearch() {
    if (_webSearch != null) _webSearch.operation.cancel();
  }

  /// Makes a new search for the query
  Future<void> searchForWord(String _word) async {
    _webSearch = CancelableCompleter();
    _webSearch.operation.value.then((result) {
      if (result != null) {
        _observable.add(result);
      }
    });
    _webSearch.complete(_apiSearchForWord(_word));
  }

  Future<Word> _apiSearchForWord(String _word) async {
    final _getRequest = url.replaceFirst("{1}", _word);
    final response = await http.get(_getRequest);
    if (response.statusCode != 200) return null;
    return _buildWord(_word, response.body);
  }

  Word _buildWord(String _word, String _responseBody) {
    String _defType;
    List<String> _items;
    Word _rez = Word(
      name: _word,
      definitions: {},
      language: languages['Romanian'],
      isFavorite: false,
    );

    final _html = parse(_responseBody);
    List<Element> _ols = _html.getElementsByTagName("ol");
    for (var i = 0; i < _ols.length; ++i) {
      _items = _ols[i].innerHtml.split("<li>");
    }
    return _rez;
  }

  PublishSubject get observable => _observable;
}
