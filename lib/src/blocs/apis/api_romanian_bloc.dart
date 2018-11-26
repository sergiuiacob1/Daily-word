import './../../models/word.dart';
import './../../models/language.dart';
import 'api_bloc_utils.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
import './../words_storage_bloc.dart';

class ApiRomanianBloc extends ApiBlocUtils {
  ApiRomanianBloc()
      : super(
          language: 'Romanian',
          getDefinitionUrl: "http://www.dex.ro/{1}",
          getDailyWordUrl: "",
        );

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
    _defType = "definitie";
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

    /// This is for Wiktionary!!!
    // final _html = parse(_responseBody);
    // final _content = _html.getElementsByClassName("mw-parser-output");
    // if (_content.length == 0) return null;
    // List<Element> _children = _content[0].children;

    // for (Element _element in _children) {
    //   if (_element.outerHtml.startsWith("<h2")) {
    //     if (_element.children != null)
    //       _defIsRomanian = (_element.children.first.id == "rom.C3.A2n.C4.83");
    //   }
    //   if (_defIsRomanian == false) continue;
    //   if (_element.outerHtml.startsWith("<h3")) {
    //     _defType = _element.text;
    //   }
    //   if (_element.outerHtml.startsWith("<ol")) {
    //     for (Element _definition in _element.children) {
    //       // process the definitions
    //       if (_rez.definitions[_defType] == null)
    //         _rez.definitions[_defType] = [];
    //       _rez.definitions[_defType].add(_definition.text);
    //     }
    //   }
    // }

    if (_rez.definitions.isEmpty) return null;

    WordsStorageBloc().addNewDailyWord(_rez);
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
