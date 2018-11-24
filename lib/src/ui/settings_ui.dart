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
        PageUtils.buildSliverAppBar(title),
        _buildContent(bloc),
      ],
    );
  }

  Widget _buildContent(SettingsBloc bloc) {
    return new SliverList(
      delegate: new SliverChildListDelegate(
        <Widget>[
          _buildLanguageSelector(bloc),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(SettingsBloc bloc) {
    return StreamBuilder(
        stream: bloc.languagesStream,
        initialData: bloc.selectedLanguages,
        builder: (context, snapshot) {
          return ExpansionTile(
            title: new Text("Language select"),
            children: languages.values
                .map((language) => CheckboxListTile(
                      title: Text(language.name),
                      value: snapshot.data.contains(language.name),
                      onChanged: (value) =>
                          bloc.languageCheck(language.name, value),
                    ))
                .toList(),
          );
        });
  }
}
