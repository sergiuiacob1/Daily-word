import 'dart:async';
import 'words_storage_bloc.dart';
import './../models/word.dart';

class TodaysWordsBloc {
  Stream _words;
  WordsStorageBloc _storageBloc = WordsStorageBloc();

  TodaysWordsBloc() {
    _words = _storageBloc.storageWordsStream;
  }

  Stream<dynamic> get words => _words;

  List<Word> get initialWords => WordsStorageBloc.words;
}
