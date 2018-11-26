import 'package:flutter/material.dart';
import 'page_utils.dart' as PageUtils;
import '../blocs/settings_bloc.dart';
import '../providers/settings_provider.dart';
import './../models/language.dart';

class SettingsUI extends StatelessWidget {
  final title = "Settings";

  @override
  Widget build(BuildContext context) {
    SettingsBloc bloc = SettingsProvider.of(context);
    return new CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        PageUtils.buildSliverAppBar(context, title),
        _buildContent(context, bloc),
      ],
    );
  }

  Widget _buildContent(BuildContext context, SettingsBloc bloc) {
    return new SliverList(
      delegate: new SliverChildListDelegate(
        <Widget>[
          _buildLanguageSelector(context, bloc),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context, SettingsBloc bloc) {
    return StreamBuilder(
        stream: bloc.languagesStream,
        initialData: [],
        builder: (context, snapshot) {
          return ExpansionTile(
            title: new Text(
              "Language select",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.title.fontSize,
              ),
            ),
            children: languages.values
                .map((language) => CheckboxListTile(
                      title: Text(
                        language.name,
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.body2.fontSize,
                        ),
                      ),
                      value: snapshot.data.contains(language.name),
                      onChanged: (value) =>
                          bloc.languageCheck(language.name, value),
                    ))
                .toList(),
          );
        });
  }
}
