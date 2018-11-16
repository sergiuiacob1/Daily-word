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
    // print(path);
    return File('$path/words_feed.txt');
  }

  Future<List<Word>> getWordsFromStorage() async {
    List<Word> _words = [];
    var _json = await readFile();
    for (var _word in _json['words']) {
      _words.add(new Word.fromJson(_word));
    }
    return _words;
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
    final file = await _localFile;
    var _allWordsJson = await readFile();

    _allWordsJson['words'].insert(0, word.toJson());
    print(_allWordsJson.toString());
    file.writeAsString(json.encode(_allWordsJson), mode: FileMode.write);
  }

  Future<File> cleanFile() async {
    final file = await _localFile;
    return file.writeAsString('');
  }
}
