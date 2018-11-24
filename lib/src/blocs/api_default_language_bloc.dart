import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import './api_bloc_utils.dart';
import './../models/word.dart';
import './../models/language.dart';

class ApiDefaultLanguageBloc extends ApiBlocUtils {
  ApiDefaultLanguageBloc({@required String language}) : super(language: language, url: 'none');

  @override
  Word buildWord(String _word, String _responseBody) {
    return Word(
      name: 'Engleza',
      definitions: {},
      isFavorite: false,
      language: languages['English'],
    );
  }
}
