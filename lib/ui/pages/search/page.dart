import 'package:flutter/material.dart';
import 'package:netflix_clone/core/services/api.dart';
import 'package:netflix_clone/ui/pages/detail/page.dart';
import 'package:netflix_clone/ui/pages/search/vm.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<Api, SearchViewModel>(
      builder: (_, api, previous) {
        final vm = (previous ?? SearchViewModel())..api = api;
        vm.initState();
        return vm;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _SearchField(),
              _SearchResult(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  _SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.grey[900],
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              size: 28,
              color: Colors.grey[100],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
            Expanded(
              child: Consumer<SearchViewModel>(
                builder: (context, vm, children) {
                  return TextField(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    cursorColor: Colors.grey[100],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'TV番組、映画、ジャンルなどで検索',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    onChanged: (text) => vm.filterItems(text),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
            Icon(
              Icons.mic,
              size: 28,
              color: Colors.grey[100],
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResult extends StatelessWidget {
  _SearchResult({Key key}) : super(key: key);

  final _popularItems = CustomScrollView(
    slivers: <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return const _ItemTitle(
              title: "注目の検索ワード",
            );
          },
          childCount: 1,
        ),
      ),
      Consumer<SearchViewModel>(
        builder: (context, vm, child) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final item = vm.popularItems[index];
                return Container(
                  padding: EdgeInsets.only(bottom: 1),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(vm.popularItems[index]),
                        ),
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        Image.network(
                          item.imageUrl,
                          width: 130,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              item.title,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              childCount: vm.popularItems.length,
            ),
          );
        },
      ),
    ],
  );

  final _items = CustomScrollView(
    slivers: <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int ind1x) {
            return const _ItemTitle(title: "映画やテレビ番組");
          },
          childCount: 1,
        ),
      ),
      Consumer<SearchViewModel>(
        builder: (context, vm, children) {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 77 / 110,
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(vm.items[index]),
                      ),
                    );
                  },
                  child: Image.network(
                    vm.items[index].imageUrl,
                    fit: BoxFit.fill,
                  ),
                );
              },
              childCount: vm.items.length,
            ),
          );
        },
      )
    ],
  );

  final _noItem = Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '残念ながら、お探しの作品は見つかりませんでした。',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            '別の映画、TV番組、俳優、監督またはジャンルを検索してみてください。',
            style: TextStyle(
              color: Colors.grey[400],
            ),
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<SearchViewModel>(
        builder: (context, vm, children) {
          switch (vm.viewState) {
            case SearchViewState.Popular:
              return _popularItems;
            case SearchViewState.NoItem:
              return _noItem;
            case SearchViewState.Items:
              return _items;
          }
          return Container();
        },
      ),
    );
  }
}

class _ItemTitle extends StatelessWidget {
  final String title;

  const _ItemTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
}
