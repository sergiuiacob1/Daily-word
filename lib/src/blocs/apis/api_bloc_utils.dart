import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import './../../models/word.dart';
import './../settings_bloc.dart';
import './../words_storage_bloc.dart';

abstract class ApiBlocUtils {
  PublishSubject _observable = PublishSubject();
  SettingsBloc settingsBloc = SettingsBloc();
  final String language, getDefinitionUrl, getDailyWordUrl;
  CancelableCompleter _webSearch;
  bool _languageIsSelected = true;

  ApiBlocUtils({
    @required this.language,
    @required this.getDefinitionUrl,
    @required this.getDailyWordUrl,
  })  : assert(language != null),
        assert(getDefinitionUrl != null),
        assert(getDailyWordUrl != null) {
    settingsBloc.languagesStream.listen((onData) {
      _languageIsSelected = settingsBloc.isLanguageSelected(language);
    });
  }

  void dispose() {
    _observable.close();
  }

  void cancelExistingSearch() {
    if (_webSearch != null) _webSearch.operation.cancel();
  }

  /// Makes a new search for the query
  Future<void> searchForWord(String _word) async {
    if (_word == '') {
      _observable.add(null);
      return;
    }
    _webSearch = CancelableCompleter();
    _webSearch.operation.value.then((result) => _observable.add(result));
    _webSearch.complete(_apiSearchForWord(_word));
  }

  /// Get results from the Internet
  Future<Word> _apiSearchForWord(String _word) async {
    Word _searchResult;
    final _getRequest = getDefinitionUrl.replaceFirst("{1}", _word);
    var response;
    try {
      response = await http.get(_getRequest);
    } catch (e) {
      debugPrint('Erroare la http get for $language: $e');
      return null;
    }
    if (response.statusCode != 200) return null;
    _searchResult = buildWord(_word, response.body);
    if (_searchResult != null) {
      _searchResult.isFavorite = WordsStorageBloc()
              .favoriteWordsStream
              .value
              .where((item) =>
                  item.name == _searchResult.name &&
                  item.language == _searchResult.language)
              .length >
          0;
    }
    return _searchResult;
  }

  /// This will be overriden based on the language
  /// Each HTTP response has a different structure, so it has to be parsed differently
  Word buildWord(String _word, String _responseBody);

  PublishSubject get observable => _observable;

  bool get languageIsSelected => _languageIsSelected;
}
