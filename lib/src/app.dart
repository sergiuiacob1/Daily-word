import 'package:flutter/material.dart';
import 'providers/dictionary_provider.dart';

class App extends StatelessWidget {
  App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DictionaryProvider(),
      ),
    );
  }
}
