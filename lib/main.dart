import 'package:flutter/material.dart';
import 'myCard.dart';
import './scrappedData.dart';
import './chart.dart';

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
      theme: ThemeData.light(),
      home: MyHomePage(title: 'Combat Covid'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  List<ScrapedData> data = [
    ScrapedData(DateTime.now(), 10000),
    ScrapedData(DateTime.now().add(new Duration(days: 1)), 5000),
    ScrapedData(DateTime.now().add(new Duration(days: 2)), 7000),
  ];

  final String title;
  static const cards = const [
    {'img': 'assets/homemade_face_mask.png', 'text': 'My first Card'},
    {'img': 'assets/homemade_face_mask.png', 'text': 'My Second Card'},
  ];

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: ListTile(
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text('Statistics'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('News'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                  title: Text('View Cases'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new Chart(data)));
                  }),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(title),
          bottom: new TabBar(tabs: <Widget>[
            new Tab(text: "Home"),
            new Tab(text: "Dummy tab 2"),
            new Tab(text: "Dummy tab 3"),
          ]),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.exit_to_app), onPressed: null)
          ],
        ),
        body: new TabBarView(children: <Widget>[
          Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: cards.map((e) => MyCard(e['img'], e['text'])).toList(),
          ),
          new Text("Dummy tab 2"),
          new Text("Dummy tab 3")
        ]),
        /*body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: cards.map((e) => MyCard(e['img'], e['text'])).toList(),
      ),*/
      ),
    );
  }
}
