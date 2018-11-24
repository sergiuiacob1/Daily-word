import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:async/async.dart';
// import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import './api_bloc_utils.dart';
import './../../models/word.dart';
import './../../models/language.dart';

class ApiDefaultLanguageBloc extends ApiBlocUtils {
  ApiDefaultLanguageBloc({@required String language})
      : super(
          language: language,
          getDefinitionUrl:
              'https://en.wiktionary.org/w/index.php?title={1}&printable=yes',
          getDailyWordUrl: '',
        );

  @override
  Word buildWord(String _word, String _responseBody) {
    String _defType = '';
    Word _rez = Word(
      name: _word + ' - ' + language,
      definitions: {},
      language: languages[language],
      isFavorite: false,
    );

    final _html = parse(_responseBody);
    final _content = _html.getElementsByClassName("mw-parser-output");
    if (_content.length == 0) return null;
    List<Element> _children = _content[0].children;

    for (Element _element in _children) {
      if (_element.outerHtml.startsWith("<h3")) {
        _defType = _element.text;
      }
      if (_element.outerHtml.startsWith("<ol")) {
        for (Element _definition in _element.children) {
          // process the definitions
          if (_rez.definitions[_defType] == null)
            _rez.definitions[_defType] = [];
          _rez.definitions[_defType].add(_definition.text);
        }
      }
    }
    return _rez;
  }
}
