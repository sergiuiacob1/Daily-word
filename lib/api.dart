import 'dart:async';
import 'word.dart';
import 'romanian_dictionary_api.dart';
import 'english_dictionary_api.dart';

class Api {
  static Future<List<Word>> getDailyWords() async {
    List<Word> _words = [];
    _words.add(await RomanianDictionaryApi.getDailyWord());
    _words.add(await EnglishDictionaryApi.getDailyWord());
    return _words;
  }
}
