import 'package:flutter/material.dart';
import 'language.dart';

class Word {
  Language language;
  String name;
  String definition;
  bool isFavorite;

  Word(
      {@required this.language,
      @required this.name,
      @required this.definition,
      @required this.isFavorite})
      : assert(language != null),
        assert(name != null),
        assert(definition != null),
        assert(isFavorite != null);
  Map<String, dynamic> toJson() => {
        'language': language.name,
        'name': name,
        'definition': definition,
        'isFavorite': isFavorite == true ? 'true' : 'false',
      };
  Word.fromJson(Map<String, dynamic> json)
      : language = Languages[json['language']],
        name = json['name'],
        definition = json['definition'],
        isFavorite = json['isFavorite'] == 'true' ? true : false;
}
