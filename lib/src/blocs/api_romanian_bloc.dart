import './../models/word.dart';
import './../models/language.dart';
import 'api_bloc_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class ApiRomanianBloc extends ApiBlocUtils {
  ApiRomanianBloc()
      : super(
          language: 'Romanian',
          url: "https://ro.wiktionary.org/wiki/{1}?printable=yes",
        );

  @override
  Word buildWord(String _word, String _responseBody) {
    String _defType;
    List<String> _items;
    Word _rez = Word(
      name: 'Romana override',
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
}
