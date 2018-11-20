import 'package:flutter/material.dart';
import 'language.dart';
import 'dart:convert';

class Word {
  Language language;
  String name;
  Map<String, List<String>> definitions;
  bool isFavorite;

  Word(
      {@required this.language,
      @required this.name,
      @required this.definitions,
      @required this.isFavorite})
      : assert(language != null),
        assert(name != null),
        assert(definitions != null),
        assert(isFavorite != null);
  Map<String, dynamic> toJson() => {
        'language': language.name,
        'name': name,
        'definitions': json.encode(definitions),
        'isFavorite': isFavorite == true ? 'true' : 'false',
      };
  Word.fromJson(Map<String, dynamic> jsonObject)
      : language = languages[jsonObject['language']],
        name = jsonObject['name'],
        definitions = json.decode(jsonObject['definitions']),
        isFavorite = jsonObject['isFavorite'] == 'true' ? true : false;
}
