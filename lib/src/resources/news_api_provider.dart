import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';

final _BASE_URL = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final response = await client.get('$_BASE_URL/topstories.json');
    final ids = json.decode(response.body);

    return ids;
  }

  fetchItems(int id) async {
    final response = await client.get('$_BASE_URL/item/$id.json');
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
