import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model.dart';

Future<List<NewsApiModel>> getNews() async {
  Uri uri = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=eb518c483f6149048dc1a54b20e344c5");

  final response = await http.get(uri);

  if (response.statusCode == 200 || response.statusCode == 201) {
    Map<String, dynamic> map = json.decode(response.body);

    List _articalsList = map['articles'];

    List<NewsApiModel> newsList = _articalsList
        .map((jsonData) => NewsApiModel.fromJson(jsonData))
        .toList();

    print(_articalsList);

    return newsList;
  } else {
    print("error");
    return [];
  }
}
