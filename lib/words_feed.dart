import 'package:flutter/material.dart';
import 'app_page.dart' as PageUtils;
import 'words_feed_storage.dart';
import 'word.dart';

class WordsFeed extends StatefulWidget {
  final WordsFeedStorage _wordsFeedStorage = new WordsFeedStorage();
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

  @override
  void initState() {
    super.initState();
    print('Creating: $widget.title');
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(
            () {
              content = _buildContent();
            },
          ),
    );
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
    List<Widget> _words = [];
    // String rez = await _wordsFeedStorage.readFile();
    _words.add(
      _buildWordWidget(
        new Word(
          name: 'Head',
          definition:
              'Superior body part. Metal head. Pies are great!Superior body part. Metal head. Pies are great!Superior body part. Metal head. Pies are great!Superior body part. Metal head. Pies are great!Superior body part. Metal head. Pies are great!Superior body part. Metal head. Pies are great!Superior body part. Metal head. Pies are great!',
          isFavorite: false,
        ),
      ),
    );
    _words.add(
      _buildWordWidget(
        new Word(
          name: 'Masina',
          definition: 'Vehicul motorizat',
          isFavorite: true,
        ),
      ),
    );
    return _words;
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Divider(),
            new Text(
              word.definition,
              style: TextStyle (fontSize: Theme.of(context).textTheme.subhead.fontSize),
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
