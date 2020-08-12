import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './scrappedData.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart extends StatelessWidget {
  final List<ScrapedData> casesList = [
    ScrapedData(DateTime.now(), 10000),
    ScrapedData(DateTime.now().add(new Duration(days: 1)), 5000),
    ScrapedData(DateTime.now().add(new Duration(days: 2)), 7000),
  ];
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
      appBar: AppBar(
        title: Text("Combat Covid"),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
