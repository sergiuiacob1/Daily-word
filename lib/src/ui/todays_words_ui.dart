import 'package:flutter/material.dart';
import 'page_utils.dart' as PageUtils;
import '../blocs/todays_words_bloc.dart';
import '../providers/todays_words_provider.dart';

class TodaysWordsUI extends StatelessWidget {
  final title = "Today's Words";

  @override
  Widget build(BuildContext context) {
    TodaysWordsBloc todaysWordsBloc = TodaysWordsProvider.of(context);
    return new CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        PageUtils.buildSliverAppBar(title),
        _buildContent(todaysWordsBloc),
      ],
    );
  }

  Widget _buildContent(TodaysWordsBloc todaysWordsBloc) {
    return StreamBuilder(
        stream: todaysWordsBloc.todaysWords,
        initialData: [],
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.length == 0)
            return SliverFillRemaining(
              child: Container(
                color: Colors.red[100],
              ),
            );

          return SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, i) {
                if (i % 2 == 0)
                  return PageUtils.buildWordWidget(
                      context, snapshot.data[i ~/ 2]);
                return Divider(
                  height: 16.0,
                );
              },
              childCount: snapshot.data.length * 2 - 1,
            ),
          );
        });
  }
}
