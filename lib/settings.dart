import 'package:flutter/material.dart';
import 'app_page.dart';

class Settings extends AppPage {
  Settings({Key key})
      : super(key: key, title: "Settings", content: _buildContent());

  static Widget _buildContent() {
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
              child: new Text("Item number settings " + i.toString(),
                  style: new TextStyle(fontSize: 20.0)))));
    }
    return strings;
  }
}
