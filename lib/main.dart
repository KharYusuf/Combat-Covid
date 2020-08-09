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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Combat Covid'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  static const cards = const [
    {'img': 'assets/homemade_face_mask.png', 'text': 'My first Card'},
    {'img': 'assets/homemade_face_mask.png', 'text': 'My Second Card'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: cards.map((e) => MyCard(e['img'], e['text'])).toList(),
      ),
    );
  }
}
