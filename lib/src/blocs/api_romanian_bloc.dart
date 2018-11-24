import './../models/word.dart';
import './../models/language.dart';
import 'api_bloc_utils.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

class ApiRomanianBloc extends ApiBlocUtils {
  ApiRomanianBloc()
      : super(
          language: 'Romanian',
          url: "https://ro.wiktionary.org/wiki/{1}?printable=yes",
        );

  @override
  Word buildWord(String _word, String _responseBody) {
    String _defType = '';
    List<String> _items;
    Word _rez = Word(
      name: _word + ' - Romanian',
      definitions: {},
      language: languages['Romanian'],
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
        //am definitii aici
        for (Element _definition in _element.children) {
          if (_rez.definitions[_defType] == null)
            _rez.definitions[_defType] = [];
          _rez.definitions[_defType].add(_definition.text);
        }
      }
    }
    return _rez;
  }
}
