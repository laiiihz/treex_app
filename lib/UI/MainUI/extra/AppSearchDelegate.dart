import 'package:flutter/material.dart';
import 'package:treex_app/UI/MainUI/extra/search/Result.dart';
import 'package:treex_app/UI/MainUI/extra/search/Suggest.dart';
import 'package:treex_app/Utils/brightnessUtil.dart';

class AppSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            this.query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: ResultWidget(
        query: query,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: SuggestWidget(query: query),
    );
  }

  @override
  String get searchFieldLabel => '搜索';
  @override
  ThemeData appBarTheme(BuildContext context) {
    return isDark(context) ? ThemeData.dark() : ThemeData.light();
  }
}
