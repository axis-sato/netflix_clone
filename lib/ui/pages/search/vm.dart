import 'package:flutter/widgets.dart';
import 'package:netflix_clone/core/responses/Item.dart';
import 'package:netflix_clone/core/services/api.dart';

class SearchViewModel extends ChangeNotifier {
  Api api;

  List<Item> items = [];
  List<Item> popularItems = [];
  SearchViewState _viewState = SearchViewState.Popular;
  SearchViewState get viewState => _viewState;

  void initState() async {
    popularItems = await api.fetchPopularItems();
    notifyListeners();
  }

  void filterItems(String query) async {
    if (query.isEmpty) {
      _setViewState(SearchViewState.Popular);
      return;
    }

    items = await api.fetchItems(query);
    if (items.isEmpty) {
      _setViewState(SearchViewState.NoItem);
    } else {
      _setViewState(SearchViewState.Items);
    }

    notifyListeners();
  }

  void _setViewState(SearchViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }
}

enum SearchViewState { Popular, NoItem, Items }
