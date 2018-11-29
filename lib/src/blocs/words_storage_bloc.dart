import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import './../models/word.dart';

class WordsStorageBloc {
  final BehaviorSubject _todaysWordsStream = BehaviorSubject(seedValue: []);
  final BehaviorSubject _favoriteWordsStream = BehaviorSubject(seedValue: []);
  List<Word> _todaysWords = [], _favoriteWords = [];
  final String _todaysWordsFileName = "todaysWords.txt",
      _favoriteWordsFileName = "favoriteWords.txt";

  static final WordsStorageBloc _singleton = WordsStorageBloc._internal();

  factory WordsStorageBloc() {
    return _singleton;
  }

  WordsStorageBloc._internal() {
    _buildWords();
    _listenToFavoriteStatusChanges();
  }

  void _listenToFavoriteStatusChanges() async {
    _favoriteWordsStream.listen((onData) {
      for (var i = 0; i < _todaysWords.length; ++i)
        if (_favoriteWords
                .where((_favWord) =>
                    _favWord.name == _todaysWords[i].name &&
                    _favWord.language == _todaysWords[i].language)
                .length >
            0)
          _todaysWords[i].isFavorite = true;
        else
          _todaysWords[i].isFavorite = false;
      _todaysWordsStream.add(_todaysWords);
    });
  }

  void _buildWords() async {
    _todaysWords = await getWordsFromStorage(_todaysWordsFileName);
    _todaysWordsStream.add(_todaysWords);
    _favoriteWords = await getWordsFromStorage(_favoriteWordsFileName);
    _favoriteWordsStream.add(_favoriteWords);
  }

  void dispose() {
    _todaysWordsStream.close();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String _fileName) async {
    final path = await _localPath;
    File _file = new File('$path/$_fileName');
    if (!_file.existsSync()) {
      _file.createSync();
      _file.writeAsString(json.encode([]), mode: FileMode.write);
    }
    return _file;
  }

  Future<List<Word>> getWordsFromStorage(String _fileName) async {
    List<Word> _words = [];
    var _json = await readFile(_fileName);
    if (_json.length == 0) return [];
    for (var _word in _json) {
      _words.add(new Word.fromJson(_word));
    }
    return _words;
  }

  Future<dynamic> readFile(String _fileName) async {
    dynamic _jsonObject;
    try {
      final file = await _localFile(_fileName);
      String content = await file.readAsString();
      if (content == '') return [];
      _jsonObject = json.decode(content);
      return _jsonObject;
    } catch (e) {
      return [];
    }
  }

  Future<void> writeFile(List<Word> _words, String _fileName) async {
    final file = await _localFile(_fileName);
    file.writeAsString(json.encode(_words), mode: FileMode.write);
  }

  void changeFavoriteStatus(Word word) {
    word.isFavorite = !word.isFavorite;
    if (word.isFavorite) // became favorite
      _favoriteWords.insert(0, word);
    else // not favorite anymore
      _favoriteWords.removeWhere(
          (item) => item.name == word.name && item.language == word.language);

    writeFile(_favoriteWords, "favoriteWords.txt");
    _favoriteWordsStream.add(_favoriteWords);
  }

  void addNewDailyWord(Word word) {
    if (_todaysWords
            .where((item) =>
                item.name == word.name && item.language == word.language)
            .length >
        0) return; // don't add the same word twice
    _todaysWords.insert(0, word);
    writeFile(_todaysWords, _todaysWordsFileName);
    _todaysWordsStream.add(_todaysWords);
  }

  BehaviorSubject get todaysWordsStream => _todaysWordsStream;
  BehaviorSubject get favoriteWordsStream => _favoriteWordsStream;
}
