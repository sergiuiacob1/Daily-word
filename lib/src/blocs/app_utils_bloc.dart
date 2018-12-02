import 'dart:async';
import './../models/word.dart';
import './internet_results_bloc.dart';
import './words_storage_bloc.dart';

class AppUtilsBloc {
  static final AppUtilsBloc _singleton = AppUtilsBloc._internal();
  WordsStorageBloc _storageBloc;
  InternetResultsBloc _internetResultsBloc;

  factory AppUtilsBloc() {
    return _singleton;
  }

  AppUtilsBloc._internal() {
    _internetResultsBloc = InternetResultsBloc();
    _storageBloc = WordsStorageBloc();
  }

  Future addDailyWords() async {
    _internetResultsBloc.wordsStream.listen((onData) {
      for (Word _word in onData) {
        _storageBloc.addNewDailyWord(_word);
      }
    });

    _internetResultsBloc.getDailyWords();
  }

  bool get isTodaysWordsEmpty => _storageBloc.isTodaysWordsEmpty;
}
