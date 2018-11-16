import 'package:flutter/material.dart';
import 'app_page.dart' as PageUtils;
import 'words_feed_storage.dart';
import 'word.dart';
import 'dex_online_api.dart';

class WordsFeed extends StatefulWidget {
  final WordsFeedStorage wordsFeedStorage = new WordsFeedStorage();
  final String title = "Words Feed";
  final PageUtils.DoubleHolder scrollOffset = new PageUtils.DoubleHolder();

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
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    print('Creating: ${widget.title}');
    _scrollController = new ScrollController(initialScrollOffset: 200.0);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(
            () {
              content =
                  _buildContent(); // this uses context, so initState() must finish first
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Build: ${widget.title}');
    return new NotificationListener(
      child: new CustomScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          PageUtils.buildSliverAppBar(widget.title),
          PageUtils.buildFutureContent(content),
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
    List<Widget> _widgets = [];
    List<Word> _words = await widget.wordsFeedStorage.getWordsFromStorage();
    _widgets.add(_buildWordWidget(await DexOnlineApi.getDailyWord()));
    for (Word _word in _words) {
      _widgets.add(
        _buildWordWidget(_word),
      );
    }
    return _widgets;
  }

  Widget _buildWordWidget(Word word) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 7.5,
      decoration: new BoxDecoration(
        border: new Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.all(
          Radius.elliptical(16.0, 16.0),
        ),
      ),
      margin: EdgeInsets.all(8.0),
      child: new ListTile(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Icon(Icons.language),
            new Text(
              word.name,
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline.fontSize),
            ),
            new Icon(Icons.favorite),
          ],
        ),
        subtitle: new Column(
          children: <Widget>[
            new Divider(),
            new Text(
              word.definition,
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.subhead.fontSize),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
