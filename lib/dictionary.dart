import 'package:flutter/material.dart';
import 'app_page.dart' as PageUtils;

class Dictionary extends StatefulWidget {
  final String title = "Dictionary";
  final PageUtils.DoubleHolder scrollOffset = new PageUtils.DoubleHolder();

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
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    content = _buildContent();
    print('Creating: ${widget.title}');
  }

  @override
  Widget build(BuildContext context) {
    print('Build: ${widget.title}');
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollController
        .jumpTo(widget.getScrollOffset())); //after build is done
    _scrollController =
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
}
