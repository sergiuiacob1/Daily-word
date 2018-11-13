import 'package:flutter/material.dart';
import 'app_page.dart';

class Dictionary extends AppPage {
  Dictionary({Key key})
      : super(key: key, title: "Dictionary", content: _buildContent());

  static Future<Widget> _buildContent() async {
    return new SliverList(
      delegate: new SliverChildListDelegate(
        buildTextViews(50),
      ),
    );
  }

  static List<Widget> buildTextViews(int count) {
    List<Widget> strings = List();
    for (int i = 0; i < count; i++) {
      strings.add(new Center(
          child: new Padding(
              padding: new EdgeInsets.all(16.0),
              child: new Text("Item number dictionary " + i.toString(),
                  style: new TextStyle(fontSize: 20.0)))));
    }
    return strings;
  }
}
