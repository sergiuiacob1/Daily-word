import 'package:flutter/material.dart';
import 'app_page.dart' as pageUtils;

class Dictionary extends StatefulWidget {
  final String title = "Dictionary";
  final pageUtils.DoubleHolder scrollOffset = new pageUtils.DoubleHolder();

  Dictionary({Key key}) : super(key: key);

  double getScrollOffset() {
    return scrollOffset.value;
  }

  void setScrollOffset(double aux) {
    scrollOffset.value = aux;
  }

  @override
  State<StatefulWidget> createState() {
    return new _DictionaryState();
  }
}


class _DictionaryState extends State<Dictionary> {
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
            // style: Theme.of(context).textTheme.display1, //HERE
          ),
          subtitle: new Text(
            _definition,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ));
  }
}