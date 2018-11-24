import 'package:flutter/material.dart';

final Map<String, Language> languages = {
  'Romanian': new Language(
      name: 'Romanian', color: Colors.blueAccent, icon: AssetImage('assets/images/romania.png')),
  'English': new Language(
      name: 'English', color: Colors.pinkAccent, icon: AssetImage('assets/images/united-kingdom.png')),
  'Italian': new Language(
      name: 'Italian', color: Colors.yellowAccent, icon: AssetImage('assets/images/italy.png')),
};

class Language {
  String name, abbreviation;
  Color color;
  AssetImage icon;

  Language({@required this.name, @required this.color, @required this.icon})
      : assert(name != null),
        assert(color != null),
        assert(icon != null) {
    switch (name) {
      case 'Romanian':
        abbreviation = 'ro';
        break;
      case 'English':
        abbreviation = 'en';
        break;
    }
  }
}
