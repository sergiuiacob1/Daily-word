import 'dart:async';
import 'word.dart';
import 'language.dart';
import 'dex_online_api.dart';

class Api {
  static Future<List<Word>> getDailyWords() async {
    List<Word> _words = [];
    _words.add(await DexOnlineApi.getDailyWord());
    return _words;
  }
}
