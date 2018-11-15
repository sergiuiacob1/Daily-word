import 'package:flutter/material.dart';

final Map<String, Language> languages = {
  'Romanian': new Language(
      name: 'Romanian', color: Colors.blueAccent, icon: Icons.language),
  'English': new Language(
      name: 'English', color: Colors.pinkAccent, icon: Icons.language),
};

class Language {
  String name;
  Color color;
  IconData icon;

  Language({@required this.name, @required this.color, @required this.icon})
      : assert(name != null),
        assert(color != null),
        assert(icon != null);
}
