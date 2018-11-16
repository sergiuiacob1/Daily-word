import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'word.dart';
import 'language.dart';

class Api {
  static Future<List<Word>> getDailyWords() async {
    List<Word> _words = [];
    _words.add(
      new Word(
          definition: 'sal',
          name: 'Nume',
          language: languages['Romanian'],
          isFavorite: false),
    );

    return _words;
  }
}
