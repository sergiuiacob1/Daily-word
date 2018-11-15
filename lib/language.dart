import 'package:flutter/material.dart';

class Language {
  String name;
  Color color;
  Icon icon;

  Language({@required this.name, @required this.color, @required this.icon})
      : assert(name != null),
        assert(color != null),
        assert(icon != null);
}
