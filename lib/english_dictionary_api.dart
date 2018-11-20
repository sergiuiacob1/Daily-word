// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'package:html/parser.dart' show parse;
// import 'dart:convert';
// import 'word.dart';
// import 'language.dart';

// class EnglishDictionaryApi {
//   EnglishDictionaryApi();

//   static Future<Word> getDailyWord() async {
//     print('Making request');
//     final response =
//         await http.get('http://learnersdictionary.com/word-of-the-day');
//     if (response.statusCode != 200) {
//       return null;
//     }
//     var document = parse(response.body);
//     String _wordName = document.getElementsByTagName("title")[0].innerHtml;
//     _wordName = _wordName.split(": ")[1].split(" - ")[0];

//     return Word(
//         language: languages['English'],
//         name: _wordName,
//         definitions: await getWordDefinition(_wordName),
//         isFavorite: false);
//   }

//   static Future<Map<String, List<String>>> getWordDefinition(
//       String _word) async {
//     final response = await http.get(
//         'https://googledictionaryapi.eu-gb.mybluemix.net/?define=go&lang=en');
//     if (response.statusCode != 200) {
//       return {};
//     }

//     return _parseResponse(response.body);
//   }

//   static Map<String, List<String>> _parseResponse(String _responseBody) {
//     // final dynamic _definitions = json.decode(_responseBody)["meaning"];
//     Map<String, List<String>> _rez = {};

//     return _rez;
//   }
// }
