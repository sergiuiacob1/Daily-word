import 'package:rxdart/rxdart.dart';
import 'api_bloc.dart';
import 'dart:async';

abstract class Bloc {
  Stream _stream = Stream.empty();

  Stream<dynamic> get stream => _stream;
}
