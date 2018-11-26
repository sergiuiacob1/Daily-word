import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'words_storage_bloc.dart';
import './../models/word.dart';

class TodaysWordsBloc {
  WordsStorageBloc _storageBloc = WordsStorageBloc();

  BehaviorSubject get todaysWords => _storageBloc.todaysWordsStream;
}
