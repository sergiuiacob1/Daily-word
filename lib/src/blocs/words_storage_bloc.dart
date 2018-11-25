import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import './../models/word.dart';

class WordsStorageBloc {
  final BehaviorSubject _storageWordsStream = BehaviorSubject(seedValue: []);
  List<Word> _words = [];

  static final WordsStorageBloc _singleton = WordsStorageBloc._internal();

  factory WordsStorageBloc() {
    return _singleton;
  }

  WordsStorageBloc._internal() {
    _buildWords();
  }

  void _buildWords() async {
    _words = await getWordsFromStorage();
    _storageWordsStream.add(_words);
  }

  void dispose() {
    _storageWordsStream.close();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    File _file = new File('$path/words.txt');
    if (!_file.existsSync()) {
      _file.createSync();
      _file.writeAsString('{"words": [] }', mode: FileMode.write);
    }
    return _file;
  }

  Future<List<Word>> getWordsFromStorage() async {
    List<Word> _words = [];
    var _json = await readFile();
    if (_json['words'].length == 0) return [];
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
      if (content == '') content = '{"words": []}';
      _jsonObject = json.decode(content);
      return _jsonObject;
    } catch (e) {
      return json.decode('{"words": []}');
    }
  }

  Future<void> writeFile(Word word) async {
    final file = await _localFile;
    var _allWordsJson = await readFile();

    /// nu scrie ACELASI CUVANT DE 2 ORI!!!
    /// DE SCHIMBATTTT/// DE SCHIMBATTTT/// DE SCHIMBATTTT/// DE SCHIMBATTTT/// DE SCHIMBATTTT/// DE SCHIMBATTTT/// DE SCHIMBATTTT/// DE SCHIMBATTTT/// DE SCHIMBATTTT/// DE SCHIMBATTTT/// DE SCHIMBATTTT/// DE SCHIMBATTTT/// DE SCHIMBATTTT/// DE SCHIMBATTTT
    _allWordsJson['words'].insert(0, word.toJson());
    _words.insert(0, word);
    _storageWordsStream.add(_words);
    file.writeAsString(json.encode(_allWordsJson), mode: FileMode.write);
  }

  BehaviorSubject get storageWordsStream => _storageWordsStream;
}
