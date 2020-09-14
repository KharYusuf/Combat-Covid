import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './scrappedData.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart extends StatelessWidget {
  List<ScrapedData> casesList;

  Chart(this.casesList);
  @override
  Widget build(BuildContext context) {
    List<charts.Series<ScrapedData, String>> series = [
      charts.Series(
        id: "Cases",
        data: casesList,
        domainFn: (ScrapedData series, _) =>
            DateFormat('yyyy-MM-dd – kk:mm').format(series.date),
        measureFn: (ScrapedData series, _) => series.cases,
        colorFn: (ScrapedData series, _) =>
            charts.ColorUtil.fromDartColor(Colors.blue),
      )
    ];
    return new Scaffold(
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
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Combat Covid"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: null)
        ],
      ),
      body: Container(
        height: 400,
        padding: EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(6.0),
            child: Column(
              children: <Widget>[
                Text("Cases per day"),
                Expanded(
                    child: charts.BarChart(
                  series,
                  animate: true,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
