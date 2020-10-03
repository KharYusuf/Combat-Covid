import 'package:Combat_Covid/providers/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCard extends StatefulWidget {
  final DocumentSnapshot item;

  MyCard(this.item);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  Future<void> _toggleFav() async {
    await Provider.of<Products>(context, listen: false)
        .toggleFav(widget.item.id);
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 250,
              child: GridTile(
                child: Image(
                  image: NetworkImage(widget.item.data()['img']),
                  fit: BoxFit.fitWidth,
                ),
                footer: GridTileBar(
                  leading: IconButton(
                    icon: Icon(Icons.my_location),
                    onPressed: () {},
                  ),
                  backgroundColor: Colors.black54,
                  trailing: StreamBuilder<DocumentSnapshot>(
                    stream: Provider.of<Products>(context).getFav,
                    builder: (context, snapshot) => snapshot.connectionState ==
                            ConnectionState.waiting
                        ? CircularProgressIndicator()
                        : IconButton(
                            icon: Icon(Icons.favorite),
                            color: snapshot.data.data()[widget.item.id] ?? false
                                ? Colors.pink
                                : Colors.white,
                            onPressed: _toggleFav,
                          ),
                  ),
                  title: Text(
                    widget.item.data()['text'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Details",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                expanded: Text(widget.item.data()['details']),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
