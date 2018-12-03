import './../../models/word.dart';
import './../../models/language.dart';
import 'api_bloc_utils.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'dart:convert';

class ApiRomanianBloc extends ApiBlocUtils {
  ApiRomanianBloc()
      : super(
          language: 'Romanian',
          getDefinitionUrl: "https://dexonline.ro/definitie/{1}/json",
          getDailyWordUrl: "https://dexonline.ro/cuvantul-zilei",
        );

  void getDailyWord() async {
    String _responseBody = await getResponseBody(getDailyWordUrl);
    if (_responseBody == '') return null;
    final _html = parse(_responseBody);
    String _wordName = _html
        .getElementsByTagName("title")[0]
        .text
        .split("): ")[1]
        .split(" | ")[0];
    searchForWords(_wordName);
  }

  Future<void> searchForWords(String _word) async {
    searchForSingleWord(_word);
  }

  @override
  Word buildWord(String _word, String _responseBody) {
    String _defType = '';
    Word _rez = Word(
      name: '',
      definitions: {},
      language: languages[language],
      isFavorite: false,
    );

    // dexonline.ro - JSON response
    final _jsonObject = json.decode(_responseBody);
    for (dynamic _definition in _jsonObject["definitions"]) {
      final _html = parse(_definition["htmlRep"]);
      final _abbrev = _html.getElementsByClassName("abbrev");
      if (_abbrev.length == 0) continue;
      _defType = _parseDefinitionType(_abbrev[0]);
      if (_defType == '') continue;
      if (_rez.definitions[_defType] == null) _rez.definitions[_defType] = [];
      _rez.definitions[_defType]
          .add(_html.getElementsByTagName("body")[0].text);
    }

    _rez.name = _jsonObject["word"];
    if (_rez.definitions.isEmpty) return null;
    return _rez;
  }

  String _parseDefinitionType(Element _element) {
    String _elementText = _element.text;
    _elementText = _elementText.replaceAll(" ", "");
    _elementText = _elementText.replaceAll("\t", "");
    switch (_elementText) {
      case "lat.":
        return "Latinesc";
      case "adj.":
        return "Adjectiv";
      case "s.n.":
        return "Substantiv";
      case "s.m.":
        return "Substantiv";
      case "s.f.":
        return "Substantiv";
      case "adv.":
        return "Adverb";
      case "interj.":
        return "Interjecție";
      case "vb.":
        return "Verb";
      case "fr.":
        return "Franceză";
      default:
        return "";
      // return _span.attributes["title"].substring(0, 1).toUpperCase() +
      //     _span.attributes["title"].substring(1).toLowerCase();
    }
  }
}
