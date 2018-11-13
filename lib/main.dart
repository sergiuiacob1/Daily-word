import 'package:flutter/material.dart';
import 'words_feed.dart';
import 'dictionary.dart';
import 'favorites.dart';
import 'settings.dart';

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
  int _selectedIndex;
  final _pageController = new PageController(initialPage: 0);
  final List<Widget> _pages = [
    new WordsFeed(),
    new Dictionary(),
    new Favorites(),
    new Settings()
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new PageView(
        controller: _pageController,
        onPageChanged: _pageChanged,
        children: _makePages(),
        // children: _pages,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _navigationBarItemTapped,
        items: _buildBottomNavigationBarItems(),
      ),
    );
  }

  List<Widget> _makePages() {
    List<Widget> pages = [
      new WordsFeed(),
      new Dictionary(),
      new Favorites(),
      new Settings()
    ];
    return pages;
  }

  void _pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigationBarItemTapped(int index) {
    setState(() {
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
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
}
