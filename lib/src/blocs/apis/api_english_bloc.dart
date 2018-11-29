import './../../models/word.dart';
import './../../models/language.dart';
import 'api_bloc_utils.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'dart:convert';
import './api_keys.dart';

class ApiEnglishBloc extends ApiBlocUtils {
  ApiEnglishBloc()
      : super(
          language: 'English',
          getDefinitionUrl:
              "https://api.wordnik.com/v4/word.json/{1}/definitions?limit=200&includeRelated=false&useCanonical=true&includeTags=false&api_key=$EnglishApiKey",
          getDailyWordUrl:
              "https://api.wordnik.com/v4/words.json/wordOfTheDay?api_key=$EnglishApiKey",
        );

  void getDailyWord() {}

  Future<void> searchForWords(String _word) async {
    searchForSingleWord(_word);
  }

  @override
  Word buildWord(String _word, String _responseBody) {
    // bool _defIsEnglish = false;
    String _defType = '';
    Word _rez = Word(
      name: _word,
      definitions: {},
      language: languages[language],
      isFavorite: false,
    );

    final _jsonObject = json.decode(_responseBody);
    for (dynamic _definition in _jsonObject) {
      _defType = _definition["partOfSpeech"];

      if (_rez.definitions[_defType] == null) _rez.definitions[_defType] = [];
      _rez.definitions[_defType].add(_definition["text"]);
    }

    if (_rez.definitions.isEmpty) return null;
    return _rez;
  }
}
