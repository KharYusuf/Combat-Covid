import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import './bottom_navigation_bar.dart';
import './main_drawer.dart';
import './myCard.dart';
import './providers/products.dart';
import './providers/auth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPageIndex = 0;

  void _setSelectedPage(index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  var _pages;

  Future<void> _refreshHome() async {
    setState(() {
      _getPages();
    });
  }

  void _getPages() {
    var cardsData = Provider.of<Products>(context);
    var cards = cardsData.getItems;
    _pages = <Widget>[
      GridView.builder(
        itemCount: cards.length,
        itemBuilder: (context, i) {
          return MyCard(
            cards[i]['img'],
            cards[i]['text'],
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
        ),
      ),
      const Text("Dummy tab 2"),
      const Text("Dummy tab 3"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).primaryColor);
    var user = Provider.of<Auth>(context);
    _getPages();
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.pink,
            ),
            onPressed: () {
              user.googleSignout();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshHome,
        child: _pages[_currentPageIndex],
      ),
      bottomNavigationBar: BottomTabs(_currentPageIndex, _setSelectedPage),
    );
  }
}
