import 'package:flutter/material.dart';

import './chart.dart';

class MyDrawer extends StatelessWidget {
  Function signout;
  MyDrawer(this.signout);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.insert_chart),
              title: Text('View Cases'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Chart()));
              },
            ),
            ListTile(
              leading: Icon(Icons.new_releases),
              title: Text('News'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                signout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
