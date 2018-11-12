import 'package:flutter/material.dart';
import 'words_feed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Word',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<String> _pageTitles = [
    "Word feed",
    "Dictionaries",
    "Favourites",
    "Settings"
  ];

  Widget _getSliverAppBar(int index) {
    return new SliverAppBar(
      expandedHeight: 150.0,
      pinned: true,
      flexibleSpace: new FlexibleSpaceBar(
        title: new Text(_pageTitles[index]),
      ),
    );
  }

  List buildTextViews(int count) {
    List<Widget> strings = List();
    for (int i = 0; i < count; i++) {
      strings.add(new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new Text("Item number " + i.toString(),
              style: new TextStyle(fontSize: 20.0))));
    }
    return strings;
  }

  Widget _getHomePageBodyContent(int index) {
    switch (index) {
      case 0:
        return new WordsFeed();
      default:
        return new SliverList(
          delegate: new SliverChildListDelegate(
            buildTextViews(50),
          ),
        );
    }
  }

  List<Widget> _getTabsContent() {
    List<Widget> tabsContent = [];
    for (var i = 0; i < 4; ++i) {
      tabsContent.add(
        new CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            _getSliverAppBar(i),
            _getHomePageBodyContent(i),
          ],
        ),
      );
    }
    return tabsContent;
  }

  List<Widget> _getTabsButtons() {
    List<Widget> widgets = [];
    for (var i = 0; i < 4; i++) {
      widgets.add(
        new Tab(
          child: new Text("Tab $i"),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: new Scaffold(
        body: new TabBarView(
          children: _getTabsContent(),
        ),
        bottomNavigationBar: new TabBar(
          labelColor: Colors.black,
          tabs: _getTabsButtons(),
        ),
      ),
    );
  }
}
