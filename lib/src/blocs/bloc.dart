import 'dart:async';

abstract class Bloc {
  Stream _stream = Stream.empty();

  Stream<dynamic> get stream => _stream;
}
