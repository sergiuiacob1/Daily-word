import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'word.dart';
import 'language.dart';

class DexOnlineApi {
  DexOnlineApi();

  static Future<Word> getDailyWord() async {
    final response = await http.get('https://dexonline.ro/cuvantul-zilei');
    var document = parse(response.body);
    var _wordName = document.getElementsByTagName("meta")[2].outerHtml;
    print('am luat: $_wordName');
    return Word(
        language: languages['Romanian'],
        name: 'Test',
        definition: 'Def',
        isFavorite: false);
  }
}
