import 'package:flutter/material.dart';

enum _ContentListType { watching, myList, popular, preview }

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(children: <Widget>[
        const _Top(),
        const _MiddleButtons(),
        _ContentList(title: '視聴中コンテンツ', type: _ContentListType.watching),
        _ContentList(title: 'プレビュー', type: _ContentListType.preview),
        _ContentList(title: 'マイリスト', type: _ContentListType.myList),
        _ContentList(title: '人気急上昇の作品', type: _ContentListType.popular),
        _Pickup(title: '配信中: シーズン3'),
        _ContentList(title: 'Netflixオリジナル', type: _ContentListType.popular),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.grey[900],
        child: Icon(Icons.cast),
      ),
    );
  }
}

class _Top extends StatelessWidget {
  const _Top({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1010 / 1188,
      child: Container(
        height: 450,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/starwars1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(
                'lib/assets/netflix.png',
                width: 50,
                height: 50,
              ),
              Container(
                child: Text(
                  'TV番組・ドラマ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                child: Text(
                  '映画',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                child: Text(
                  'マイリスト',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiddleButtons extends StatelessWidget {
  const _MiddleButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.add,
                  size: 28,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                Text(
                  'マイリスト',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            color: Colors.transparent,
            onPressed: () {},
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.play_arrow,
                  size: 32,
                ),
                Text(
                  '再生',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            color: Colors.white,
            onPressed: () {},
          ),
          FlatButton(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.info_outline,
                  size: 28,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                Text(
                  '詳細情報',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            color: Colors.transparent,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _ContentList extends StatelessWidget {
  final images = List<String>.generate(12, (i) => "lib/assets/${i + 1}.jpg");
  final previewContentHeight = 120.0;
  final String title;
  final _ContentListType type;
  final isPreview;
  final showStart;
  final withInfo;
  final contentHeight;

  _ContentList({Key key, this.title, this.type})
      : isPreview = type == _ContentListType.preview,
        showStart = type == _ContentListType.watching,
        withInfo = type == _ContentListType.watching,
        contentHeight = type == _ContentListType.watching ? 200.0 : 160.0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            height: isPreview ? previewContentHeight : contentHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int i) {
                return Padding(
                  child: isPreview
                      ? Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                width: previewContentHeight,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: [
                                      Colors.red,
                                      Colors.yellow,
                                      Colors.white
                                    ][i % 3],
                                    width: 3.0,
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(images[i]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(images[i]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: showStart
                                    ? Icon(
                                        Icons.play_circle_outline,
                                        color: Colors.white,
                                        size: 65,
                                      )
                                    : null,
                              ),
                            ),
                            withInfo
                                ? Container(
                                    height: 40,
                                    width: 120,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          'シーズン\n4-4',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Icon(
                                          Icons.info_outline,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                );
              },
              itemCount: images.length,
            ),
          )
        ],
      ),
    );
  }
}

class _Pickup extends StatelessWidget {
  final String title;

  _Pickup({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Image.asset('lib/assets/birdboxBanner.jpg'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.play_arrow,
                              size: 32,
                            ),
                            Text(
                              '再生',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                    Expanded(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              size: 32,
                              color: Colors.white,
                            ),
                            Text(
                              'マイリスト',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        color: Colors.grey[800],
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
