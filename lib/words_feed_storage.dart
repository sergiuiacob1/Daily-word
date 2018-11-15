import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'word.dart';

class WordsFeedStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print('Path-ul este: ');
    print(path);
    return File('$path/words_feed.txt');
  }

  Future<dynamic> readFile() async {
    dynamic _jsonObject;

    try {
      final file = await _localFile;
      String content = await file.readAsString();
      _jsonObject = json.decode(content);
      return _jsonObject;
    } catch (e) {
      return '';
    }
  }

  Future<void> writeFile(Word word) async {
    dynamic _allWordsJson;
    final file = await _localFile;
    String content = await file.readAsString();

    _allWordsJson = json.decode('{words:[]}');
    _combineJsonObjects(_allWordsJson, word);
    print ('Acum scriu: ');
    print (_allWordsJson);

    return file.writeAsString(_allWordsJson.toString(), mode: FileMode.write);
  }

  void _combineJsonObjects(dynamic _bigJsonObject, Word word) {
    int _count = (_bigJsonObject['words'] as List).length;
    _bigJsonObject['words'][_count] = word.toJson();
  }

  Future<File> cleanFile() async {
    final file = await _localFile;
    return file.writeAsString('');
  }
}
