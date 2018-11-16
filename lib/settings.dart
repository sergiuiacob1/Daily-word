import 'package:flutter/material.dart';
import 'page_utils.dart' as pageUtils;

class Settings extends StatefulWidget {
  final String title = "Settings";

  Settings({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
  Future<Widget> content;

  @override
  void initState() {
    super.initState();
    content = _buildContent();
    print('Creating: $widget.title');
  }

  @override
  Widget build(BuildContext context) {
    print('Build: $widget.title');
    return new CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        pageUtils.buildSliverAppBar(widget.title),
        pageUtils.buildFutureContent(content),
      ],
    );
  }

  Future<Widget> _buildContent() async {
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
