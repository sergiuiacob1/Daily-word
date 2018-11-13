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
  static List<IconData> _pageIcons = [
    Icons.library_books,
    Icons.library_books,
    Icons.favorite,
    Icons.settings
  ];
  List<ScrollController> _scrollViewController = [];
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 4; i++) {
      _scrollViewController.add(new ScrollController());
    }
    _selectedIndex = 0;
  }

  @override
  void dispose() {
    for (var i = 0; i < 4; i++) {
      _scrollViewController[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPageContent(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _navigationBarItemTapped,
        items: _buildBottomNavigationBarItems(),
      ),
    );
  }

  void _navigationBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPageContent(int index) {
    return new CustomScrollView(
      controller: _scrollViewController[index],
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        _getSliverAppBar(index),
        _getTabContent(index),
      ],
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    List<BottomNavigationBarItem> _items = [];
    for (var i = 0; i < 4; i++) {
      _items.add(
        new BottomNavigationBarItem(
          icon: new Icon(_pageIcons[i]),
          title: new Text(_pageTitles[i]),
        ),
      );
    }
    return _items;
  }

  Widget _getSliverAppBar(int index) {
    return new SliverAppBar(
      expandedHeight: 200.0,
      pinned: true,
      flexibleSpace: new FlexibleSpaceBar(
        title: new Text(_pageTitles[index]),
      ),
    );
  }

  List<Widget> buildTextViews(int count) {
    List<Widget> strings = List();
    for (int i = 0; i < count; i++) {
      strings.add(new Center(
          child: new Padding(
              padding: new EdgeInsets.all(16.0),
              child: new Text("Item number " + i.toString(),
                  style: new TextStyle(fontSize: 20.0)))));
    }
    return strings;
  }

  Widget _getTabContent(int index) {
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
}
