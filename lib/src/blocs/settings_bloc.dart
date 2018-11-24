import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  PublishSubject languagesStreamController = PublishSubject();
  SharedPreferences _pref;
  List<String> _selectedLanguages;

  SettingsBloc() {
    _selectedLanguages = [];
    _buildSelectedLanguages();
  }

  void dispose() {
    languagesStreamController.close();
  }

  void _buildSelectedLanguages() async {
    _pref = await SharedPreferences.getInstance();
    _selectedLanguages = _pref.getStringList("SelectedLanguages") ?? [];
  }

  void languageCheck(String languageName, bool value) async {
    if (value)
      _selectedLanguages.add(languageName);
    else
      _selectedLanguages.removeWhere((item) => item == languageName);

    if (_pref != null) {
      await _pref.setStringList("SelectedLanguages", _selectedLanguages);
      languagesStreamController.add(_selectedLanguages);
    }
  }

  Stream get languagesStream =>
      languagesStreamController.stream.asBroadcastStream();

  List<String> get selectedLanguages => _selectedLanguages;
}
