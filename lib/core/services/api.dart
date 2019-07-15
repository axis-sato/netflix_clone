import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:netflix_clone/core/responses/Item.dart';

class Api {
  static const endpoint = "http://localhost:8000";

  final _client = http.Client();

  Future<List<Item>> fetchItems(String query) async {
    final response = await _client.get('$endpoint/items?query=$query');
    final itemMapList = json.decode(response.body) as List<dynamic>;
    return itemMapList.map((itemMap) => Item.fromJson(itemMap)).toList();
  }

  Future<List<Item>> fetchPopularItems() async {
    final response = await _client.get('$endpoint/popular_items');
    final itemMapList = json.decode(response.body) as List<dynamic>;
    return itemMapList.map((itemMap) => Item.fromJson(itemMap)).toList();
  }

  void dispose() {
    _client.close();
  }
}
