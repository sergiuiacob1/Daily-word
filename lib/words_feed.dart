import 'package:flutter/material.dart';
import 'app_page.dart' as pageUtils;
import 'words_feed_storage.dart';

class WordsFeed extends StatefulWidget {
  final WordsFeedStorage _wordsFeedStorage = new WordsFeedStorage();
  final String title = "Words Feed";
  final pageUtils.DoubleHolder scrollOffset = new pageUtils.DoubleHolder();

  WordsFeed({Key key}) : super(key: key);

  double getScrollOffset() {
    return scrollOffset.value;
  }

  void setScrollOffset(double aux) {
    scrollOffset.value = aux;
  }

  @override
  State<StatefulWidget> createState() {
    return new _WordsFeedState();
  }
}

class _WordsFeedState extends State<WordsFeed> {
  Future<Widget> content;

  @override
  void initState() {
    super.initState();
    print('Creating: $widget.title');
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          content = _buildContent();
        }));
  }

  @override
  Widget build(BuildContext context) {
    print('Build: $widget.title');
    ScrollController _scrollController =
        new ScrollController(initialScrollOffset: widget.getScrollOffset());
    return new NotificationListener(
      child: new CustomScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          pageUtils.buildSliverAppBar(widget.title),
          pageUtils.buildFutureContent(content),
        ],
      ),
      onNotification: (notification) {
        if (notification is ScrollNotification) {
          widget.setScrollOffset(notification.metrics.pixels);
        }
      },
    );
  }

  Future<Widget> _buildContent() async {
    List<Widget> _words = await _buildWords();
    return new SliverList(
      delegate: new SliverChildListDelegate(
        _words,
      ),
    );
  }

  Future<List<Widget>> _buildWords() async {
    List<Widget> _words = [];
    // String rez = await _wordsFeedStorage.readFile();
    _words.add(
      _buildWordTile('Head', 'Superior body part. Metal head. Pies are great!'),
    );
    return _words;
  }

  Widget _buildWordTile(String _title, String _definition) {
    return new Container(
        alignment: Alignment.center,
        color: Colors.pink[50],
        width: 200.0,
        height: 100.0,
        child: new ListTile(
          title: new Text(
            _title,
            style: Theme.of(context).textTheme.display1, //HERE
          ),
          subtitle: new Text(
            _definition,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ));
  }
}
