import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'dart:convert';

class ApiDefaultLanguageBloc {
  PublishSubject _observable = PublishSubject();
  final String _language;

  ApiDefaultLanguageBloc(this._language);

  void dispose() {
    _observable.close();
  }

  void cancelExistingSearch(){
    // if (_webSearch != null && _webSearch.isCompleted == false)
    //   _webSearch.operation.cancel();
  }

  Future<void> searchForWord(String _word) async {
    print ('Searching in default');
  }

  PublishSubject get observable => _observable;
}
