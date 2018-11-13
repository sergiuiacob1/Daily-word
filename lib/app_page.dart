import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppPage extends StatefulWidget {
  final String title;
  final Widget content;
  AppPage({Key key, @required this.title, @required this.content})
      : assert(title != null),
        assert(content != null),
        super(key: key);

  @override
  _AppPageState createState() => new _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => _updateScroll(context));
  }

  // void _updateScroll(BuildContext context) {
  //   _scrollController.jumpTo(_scrollController.offset);
  // }

  @override
  Widget build(BuildContext context) {
    return new NotificationListener(
      child: new CustomScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          _buildSliverAppBar(),
          widget.content,
        ],
      ),
      onNotification: _onNotification,
    );
  }

  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      _scrollController.jumpTo(notification.metrics.pixels);
    }
    return true;
  }

  Widget _buildSliverAppBar() {
    return new SliverAppBar(
      expandedHeight: 200.0,
      pinned: true,
      flexibleSpace: new FlexibleSpaceBar(
        title: new Text(widget.title),
      ),
    );
  }
}
