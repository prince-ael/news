import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';

final topIdTestDesc = "Fetch test for top news id of hacker api";
final fetchItemTestDesc =
    "Fetch test for top news according to selected id of hacker api";

final expectedTopids = [500, 600, 1, 11, 2];
final expectedNewsItem = {
  "by": "norvig",
  "id": 2921983,
  "kids": [2922097, 2922429, 2924562, 2922709, 2922573, 2922140, 2922141],
  "parent": 2921507,
  "text": "Very Good Message",
  "time": 1314211120,
  "type": "comment"
};

Future<Response> topIdMockHandler(Request request) async =>
    Response(json.encode(expectedTopids), 200);

Future<Response> newsItemMockHandler(Request request) async =>
    Response(json.encode(expectedNewsItem), 200);

void topIdTest() async {
  final newsApiProvider = NewsApiProvider();
  newsApiProvider.client = MockClient(topIdMockHandler);

  final ids = await newsApiProvider.fetchTopIds();
  expect(ids, expectedTopids);
}

void newsItemTest() async {
  final newsApiProvider = NewsApiProvider();
  newsApiProvider.client = MockClient(newsItemMockHandler);

  final newsItem = await newsApiProvider.fetchItems(2921983);
  expect(newsItem.id, expectedNewsItem["id"]);
  expect(newsItem.parent, expectedNewsItem["parent"]);
  expect(newsItem.time, expectedNewsItem["time"]);
}

void main() {
  test(topIdTestDesc, topIdTest);
}
