import 'package:flutter/material.dart';
import 'app_page.dart';
import 'words_feed_storage.dart';

class WordsFeed extends AppPage {
  static WordsFeedStorage _wordsFeedStorage = new WordsFeedStorage();
  WordsFeed({Key key})
      : super(key: key, title: "Words Feed", content: _buildContent());

  static Future<Widget> _buildContent() async {
    List<Widget> _words = await _buildWords();
    return new SliverList(
      delegate: new SliverChildListDelegate(
        _words,
      ),
    );
  }

  static Future<List<Widget>> _buildWords() async {
    List<Widget> _words = [];
    String rez = await _wordsFeedStorage.readFile();
    _words.add(
      new Text(
        rez,
      ),
    );
    return _words;
  }
}
