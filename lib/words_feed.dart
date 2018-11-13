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
    // String rez = await _wordsFeedStorage.readFile();
    _words.add(
      _buildWordTile('Head', 'Superior body part. Metal head. Pies are great!'),
    );
    return _words;
  }

  static Widget _buildWordTile(String _title, String _definition) {
    return new Container(
        alignment: Alignment.center,
        color: Colors.pink[50],
        width: 200.0,
        height: 100.0,
        child: new ListTile(
          title: new Text(
            _title,
            // style: Theme.of(context).textTheme.display1, //HERE
          ),
          subtitle: new Text(
            _definition,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ));
  }
}
