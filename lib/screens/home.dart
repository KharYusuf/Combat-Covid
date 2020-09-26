import 'package:Combat_Covid/screens/favScreen.dart';
import 'package:Combat_Covid/widgets/shop_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../widgets/bottom_navigation_bar.dart';
import '../widgets/main_drawer.dart';
import '../providers/products.dart';
import '../widgets/masks.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, String> metadata = Map();

  int _currentPageIndex = 0;
  final List<Widget> _pages = <Widget>[
    Masks(),
    const Text("Dummy tab 2"),
    const Text("Dummy tab 3"),
  ];

  @override
  void initState() {
    Provider.of<Products>(context, listen: false).setItems();
    super.initState();
  }

  void _setSelectedPage(index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).primaryColor);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FavScreen(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: ShopPickerDialog(),
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomTabs(_currentPageIndex, _setSelectedPage),
    );
  }
}
