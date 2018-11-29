import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import './../../models/word.dart';
import './../settings_bloc.dart';
import './../words_storage_bloc.dart';

abstract class ApiBlocUtils {
  PublishSubject _resultsStream = PublishSubject();
  SettingsBloc settingsBloc = SettingsBloc();
  final String language, getDefinitionUrl, getDailyWordUrl;
  List<CancelableCompleter> webSearches = [];
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
    _resultsStream.close();
  }

  void cancelExistingSearches() {
    for (CancelableCompleter _item in webSearches) _item.operation.cancel();
    webSearches.clear();
  }

  Future<void> searchForWords(String _word);

  Future<void> searchForSingleWord(String _word) async {
    if (_word == '') {
      _resultsStream.add(null);
      return;
    }
    CancelableCompleter _webSearch = CancelableCompleter();
    _webSearch.operation.value.then((result) {
      // my search is done
      webSearches.remove(_webSearch);
      resultsStream.add(result);
    });
    _webSearch.complete(apiSearchForWord(_word));
    webSearches.add(_webSearch);
  }

  // Future<String> getResponseBody(String _url) async {
  //   String _getRequest = _url;
  //   var isRedirect = true;
  //   http.StreamedResponse response;

  //   while (isRedirect) {
  //     final client = http.Client();
  //     final request = http.Request('GET', Uri.parse(_getRequest))
  //       ..followRedirects = false;
  //     response = await client.send(request);
  //     switch (response.statusCode) {
  //       case HttpStatus.notFound:
  //         return '';
  //       case HttpStatus.ok:
  //         return '';
  //       case HttpStatus.movedPermanently:
  //       case HttpStatus.movedTemporarily:
  //         isRedirect = response.isRedirect;
  //         // debugPrint(response.headers["location"]);
  //         // List<int> _list = [];
  //         // for (var i = 0; i < response.headers["location"].length; ++i)
  //         //   _list.add(response.headers["location"].codeUnitAt(i));
  //         // debugPrint(_list.toString());

  //         if (_getRequest.endsWith("pasarela") == false) return '';
  //         _getRequest = response.headers['location'];

  //         final client2 = http.Client();
  //         final request2 = http.Request('GET', Uri.parse(_getRequest))
  //           ..followRedirects = false;
  //         final response2 = await client2.send(request2);
  //         debugPrint('Ia ce am:');
  //         debugPrint('redirect');
  //         return '';
  //         break;
  //     }
  //   }

  //   return '';
  // }

  Future<String> getResponseBody(String _url) async {
    var _getRequest = _url;
    var response;
    try {
      response = await http.get(_getRequest);
    } catch (e) {
      debugPrint('Erroare la http get for $language: $e');
      return '';
    }
    return response.body;
  }

  /// Get results from the Internet
  Future<Word> apiSearchForWord(String _word) async {
    Word _searchResult;
    String _responseBody = await getResponseBody(
      getDefinitionUrl.replaceFirst("{1}", _word),
    );
    if (_responseBody == null || _responseBody == '') return null;
    _searchResult = buildWord(_word, _responseBody);
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
  ///
  /// Each HTTP response has a different structure, so it has to be parsed differently
  Word buildWord(String _word, String _responseBody);

  PublishSubject get resultsStream => _resultsStream;

  bool get languageIsSelected => _languageIsSelected;

  bool get isStillSearching => webSearches.length > 0;
}
