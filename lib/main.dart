import 'package:Combat_Covid/main_drawer.dart';

import './bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'myCard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
          primarySwatch: Colors.grey,
          accentColor: Colors.black,
          colorScheme: ColorScheme.dark()),
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: MyHomePage(title: 'Combat Covid'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const cards = const [
    {'img': 'assets/homemade_face_mask.png', 'text': 'My first Card'},
    {'img': 'assets/homemade_face_mask.png', 'text': 'My Second Card'},
    {'img': 'assets/homemade_face_mask.png', 'text': 'My Second Card'},
    {'img': 'assets/homemade_face_mask.png', 'text': 'My Second Card'},
    {'img': 'assets/homemade_face_mask.png', 'text': 'My Second Card'},
    {'img': 'assets/homemade_face_mask.png', 'text': 'My Second Card'},
    {'img': 'assets/homemade_face_mask.png', 'text': 'My Second Card'},
  ];

  final _pages = <Widget>[
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

  int _currentPageIndex = 0;

  void _setSelectedPage(index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(Icons.shopping_basket),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomTabs(_currentPageIndex, _setSelectedPage),
    );
  }
}
