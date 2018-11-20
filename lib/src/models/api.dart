import 'word.dart';
import 'language.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'dart:convert';

class Api {
  Future<List<Word>> getWords(String query) async {
    List<Word> words = [];
    if (query.isEmpty) return [];
    for (String lang in languages.keys)
      if (languageIsActive(lang))
        words.addAll(getWordsForLanguage(lang, query));

    return words;
  }

  bool languageIsActive(String lang) {
    if (lang == 'English') return true;
    return false;
  }

  List<Word> getWordsForLanguage(String lang, String query) {
    switch (lang) {
      case 'English':
        return getWordsEnglish(query);

      default:
        return [];
    }
  }

  List<Word> getWordsEnglish(String query) {
    return [];
  }
}
