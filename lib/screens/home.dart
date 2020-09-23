import 'package:Combat_Covid/screens/favScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
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

  final _formKey = GlobalKey<FormState>();

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
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                    right: -40.0,
                    top: -40.0,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.close),
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Name of Shop",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                              child: Text("Select your Shop's Location"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlacePicker(
                                      apiKey:
                                          'AIzaSyC39Xs7KWEucJ3I8VElpG6LkGAzALD12ME',
                                      onPlacePicked: (result) {
                                        print(result.adrAddress);
                                        Navigator.of(context).pop();
                                      },
                                      initialPosition: LatLng(28.7041, 77.1025),
                                      useCurrentLocation: true,
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            child: Text("Submit"),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomTabs(_currentPageIndex, _setSelectedPage),
    );
  }
}
