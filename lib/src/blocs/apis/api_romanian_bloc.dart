import './../../models/word.dart';
import './../../models/language.dart';
import 'api_bloc_utils.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

class ApiRomanianBloc extends ApiBlocUtils {
  ApiRomanianBloc()
      : super(
          language: 'Romanian',
          getDefinitionUrl: "http://www.dex.ro/{1}",
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
      name: _word,
      definitions: {},
      language: languages[language],
      isFavorite: false,
    );

    /// Definitions from dex.ro
    final _html = parse(_responseBody);
    var _resultsWrapper = _html.getElementById("results");
    if (_resultsWrapper == null) return null;
    List<Element> _definitions = _resultsWrapper.getElementsByClassName("res");
    for (Element _definition in _definitions) {
      // find out definition type
      dynamic _span = _definition.children
          .where((_element) => _element.outerHtml.startsWith("<span"));
      if (_span.length == 0)
        continue;
      else
        _defType = _parseDefinitionType(_span.first);
      if (_defType == '') continue;
      if (_rez.definitions[_defType] == null) _rez.definitions[_defType] = [];
      _rez.definitions[_defType].add(_definition.text);
    }

    if (_rez.definitions.isEmpty) return null;
    return _rez;
  }

  String _parseDefinitionType(Element _span) {
    String _spanText = _span.text;
    _spanText = _spanText.replaceAll(" ", "");
    _spanText = _spanText.replaceAll("\t", "");
    switch (_spanText) {
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
        return _span.attributes["title"].substring(0, 1).toUpperCase() +
            _span.attributes["title"].substring(1).toLowerCase();
    }
  }
}
