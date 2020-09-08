import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/chart.dart';
import '../providers/auth.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer();

  @override
  Widget build(BuildContext context) {
    final loginData = Provider.of<Auth>(context, listen: false);
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
              onTap: loginData.googleSignout,
            ),
          ],
        ),
      ),
    );
  }
}
