import 'package:flutter/material.dart';

class WordsFeed extends StatefulWidget {
  WordsFeed({Key key}) : super(key: key);

  @override
  _WordsFeedState createState() => new _WordsFeedState();
}

class _WordsFeedState extends State<WordsFeed> {
  @override
  Widget build(BuildContext context) {
    return new SliverList(
      delegate: new SliverChildListDelegate(
        _buildTextViews(50),
      ),
    );
  }

  List _buildTextViews(int count) {
    List<Widget> strings = List();
    for (int i = 0; i < count; i++) {
      strings.add(new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new Text("This is word feed",
              style: new TextStyle(fontSize: 20.0))));
    }
    return strings;
  }
}
