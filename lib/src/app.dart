import 'package:flutter/material.dart';
import 'providers/dictionary_provider.dart';
import 'providers/todays_words_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/settings_provider.dart';
import './blocs/word_notifier_bloc.dart';
import './blocs/app_utils_bloc.dart';

class App extends StatelessWidget {
  final WordNotifierBloc _wordNotifier = WordNotifierBloc();
  final AppUtilsBloc _appUtilsBloc = AppUtilsBloc();

  App() {
    _initialize();
  }

  void _initialize() async {
    if (_appUtilsBloc.isTodaysWordsEmpty) _appUtilsBloc.addDailyWords();

    // schedule notifications
    _wordNotifier.scheduleNotification();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Word',
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.deepOrangeAccent,
        textTheme: TextTheme(
          title: TextStyle(fontSize: 22.0),
          body2: TextStyle(fontSize: 18.0),
        ),
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
    "Today's Words",
    "Dictionary",
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
    TodaysWordsProvider(),
    DictionaryProvider(),
    FavoritesProvider(),
    SettingsProvider(),
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
        children: _pages,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _navigationBarItemTapped,
        items: _buildBottomNavigationBarItems(),
      ),
    );
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
    for (var i = 0; i < _pages.length; i++) {
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
