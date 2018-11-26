import './../../models/word.dart';
import './../../models/language.dart';
import 'api_bloc_utils.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'package:async/async.dart';

class ApiEnglishBloc extends ApiBlocUtils {
  ApiEnglishBloc()
      : super(
          language: 'English',
          getDefinitionUrl:
              "https://en.wiktionary.org/w/index.php?title={1}&printable=yes",
          getDailyWordUrl: "",
        );

  @override
  Future<void> searchForWord(String _word) async {
    if (_word == '') {
      resultsStream.add(null);
      return;
    }
    CancelableCompleter _webSearch = CancelableCompleter();
    _webSearch.operation.value.then((result) => resultsStream.add(result));
    _webSearch.complete(apiSearchForWord(_word));
    webSearches.add(_webSearch);
  }

  @override
  Word buildWord(String _word, String _responseBody) {
    bool _defIsEnglish = false;
    String _defType = '';
    Word _rez = Word(
      name: _word,
      definitions: {},
      language: languages[language],
      isFavorite: false,
    );

    final _html = parse(_responseBody);
    final _content = _html.getElementsByClassName("mw-parser-output");
    if (_content.length == 0) return null;
    List<Element> _children = _content[0].children;

    for (Element _element in _children) {
      if (_element.outerHtml.startsWith("<h2")) {
        if (_element.children != null)
          _defIsEnglish = (_element.children.first.id == "English");
      }
      if (_defIsEnglish == false) continue;
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
    if (_rez.definitions.isEmpty) return null;
    return _rez;
  }
}
