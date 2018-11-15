import 'package:flutter/material.dart';
import 'language.dart';

class Word {
  Language language;
  String name;
  String definition;
  bool isFavorite;

  Word({@required this.name, @required this.definition, @required this.isFavorite})
      : assert(name != null),
        assert(definition != null),
        assert(isFavorite != null);
}
