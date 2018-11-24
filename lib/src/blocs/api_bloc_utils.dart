import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import './../models/word.dart';
import './../models/language.dart';

abstract class ApiBlocUtils {
  PublishSubject _observable = PublishSubject();
  final String language, url;
  CancelableCompleter _webSearch;

  ApiBlocUtils({this.language, @required this.url})
      : assert(language != null),
        assert(url != null);

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

  /// Get results from the Internet
  Future<Word> _apiSearchForWord(String _word) async {
    final _getRequest = url.replaceFirst("{1}", _word);
    var response;
    try {
      response = await http.get(_getRequest);
    } catch (e) {
      debugPrint('Erroare la http get for $language');
      return null;
    }
    if (response.statusCode != 200) return null;
    return buildWord(_word, response.body);
  }

  /// This will be overriden based on the language
  /// Each HTTP response has a different structure, so it has to be parsed differently
  Word buildWord(String _word, String _responseBody);

  PublishSubject get observable => _observable;
}
