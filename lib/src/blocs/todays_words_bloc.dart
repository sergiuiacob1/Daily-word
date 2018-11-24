import 'package:rxdart/rxdart.dart';
import 'dart:async';

class TodaysWordsBloc {
  Stream _words = Stream.empty();

  Stream<dynamic> get words => _words;
}
