import 'package:flutter/material.dart';
import 'package:netflix_clone/core/services/api.dart';
import 'package:netflix_clone/ui/pages/home/page.dart';
import 'package:netflix_clone/ui/pages/search/page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          builder: (_) => Api(),
          dispose: (_, Api api) => api.dispose(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _MyHomePage(),
      ),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  _MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    Text(
      'ダウンロード',
      style: TextStyle(color: Colors.white),
    ),
    Text(
      'その他',
      style: TextStyle(color: Colors.white),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('ホーム'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('検索'),
          ),
          BottomNavigationBarItem(
            title: Text('ダウンロード'),
            icon: Icon(Icons.file_download),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text('その他'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        onTap: _onItemTapped,
      ),
    );
  }
}
