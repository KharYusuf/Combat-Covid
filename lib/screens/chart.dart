import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/scrappedData.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart extends StatelessWidget {
  final List<ScrapedData> casesList = [
    ScrapedData(DateTime.now().add(new Duration(days: -6)), 40000),
    ScrapedData(DateTime.now().add(new Duration(days: -5)), 35000),
    ScrapedData(DateTime.now().add(new Duration(days: -4)), 37000),
    ScrapedData(DateTime.now().add(new Duration(days: -3)), 35000),
    ScrapedData(DateTime.now().add(new Duration(days: -2)), 33000),
    ScrapedData(DateTime.now().add(new Duration(days: -1)), 30000),
    ScrapedData(DateTime.now(), 31000),
  ];
  final List<ScrapedData> deathsList = [
    ScrapedData(DateTime.now().add(new Duration(days: -6)), 900),
    ScrapedData(DateTime.now().add(new Duration(days: -5)), 800),
    ScrapedData(DateTime.now().add(new Duration(days: -4)), 950),
    ScrapedData(DateTime.now().add(new Duration(days: -3)), 700),
    ScrapedData(DateTime.now().add(new Duration(days: -2)), 750),
    ScrapedData(DateTime.now().add(new Duration(days: -1)), 700),
    ScrapedData(DateTime.now(), 688),
  ];
  final List<ScrapedData> testsList = [
    ScrapedData(DateTime.now().add(new Duration(days: -6)), 1000000),
    ScrapedData(DateTime.now().add(new Duration(days: -5)), 1100021),
    ScrapedData(DateTime.now().add(new Duration(days: -4)), 1100120),
    ScrapedData(DateTime.now().add(new Duration(days: -3)), 921421),
    ScrapedData(DateTime.now().add(new Duration(days: -2)), 1200321),
    ScrapedData(DateTime.now().add(new Duration(days: -1)), 1200300),
    ScrapedData(DateTime.now(), 1102200),
  ];
  @override
  Widget build(BuildContext context) {
    List<charts.Series<ScrapedData, String>> cases = [
      charts.Series(
        id: "Cases",
        data: casesList,
        domainFn: (ScrapedData series, _) =>
            DateFormat('dd-MM').format(series.date),
        measureFn: (ScrapedData series, _) => series.cases,
        colorFn: (ScrapedData series, _) =>
            charts.ColorUtil.fromDartColor(Colors.blue),
      )
    ];

    List<charts.Series<ScrapedData, String>> deaths = [
      charts.Series(
        id: "Cases",
        data: deathsList,
        domainFn: (ScrapedData series, _) =>
            DateFormat('dd-MM').format(series.date),
        measureFn: (ScrapedData series, _) => series.cases,
        colorFn: (ScrapedData series, _) =>
            charts.ColorUtil.fromDartColor(Colors.blue),
      )
    ];

    List<charts.Series<ScrapedData, String>> tests = [
      charts.Series(
        id: "Cases",
        data: testsList,
        domainFn: (ScrapedData series, _) =>
            DateFormat('dd-MM').format(series.date),
        measureFn: (ScrapedData series, _) => series.cases,
        colorFn: (ScrapedData series, _) =>
            charts.ColorUtil.fromDartColor(Colors.blue),
      )
    ];

    return new Scaffold(
      appBar: AppBar(
        title: Text("Statistics"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Column(
                    children: <Widget>[
                      Text("New Cases per day"),
                      Expanded(
                        child: charts.BarChart(
                          cases,
                          animate: true,
                          domainAxis: new charts.OrdinalAxisSpec(
                            renderSpec: new charts.SmallTickRendererSpec(
                              labelStyle: new charts.TextStyleSpec(
                                fontSize: 14,
                                color: charts
                                    .MaterialPalette.blue.shadeDefault.darker,
                              ),
                              lineStyle: new charts.LineStyleSpec(
                                color: charts
                                    .MaterialPalette.blue.shadeDefault.darker,
                              ),
                            ),
                          ),
                          primaryMeasureAxis: new charts.NumericAxisSpec(
                            renderSpec: new charts.GridlineRendererSpec(
                              labelStyle: new charts.TextStyleSpec(
                                fontSize: 14,
                                color: charts
                                    .MaterialPalette.blue.shadeDefault.darker,
                              ),
                              lineStyle: new charts.LineStyleSpec(
                                color: charts
                                    .MaterialPalette.blue.shadeDefault.darker,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 400,
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Column(
                    children: <Widget>[
                      Text("Deaths per day"),
                      Expanded(
                        child: charts.BarChart(
                          deaths,
                          animate: true,
                          domainAxis: new charts.OrdinalAxisSpec(
                            renderSpec: new charts.SmallTickRendererSpec(
                              labelStyle: new charts.TextStyleSpec(
                                fontSize: 14,
                                color: charts
                                    .MaterialPalette.blue.shadeDefault.darker,
                              ),
                              lineStyle: new charts.LineStyleSpec(
                                color: charts
                                    .MaterialPalette.blue.shadeDefault.darker,
                              ),
                            ),
                          ),
                          primaryMeasureAxis: new charts.NumericAxisSpec(
                            renderSpec: new charts.GridlineRendererSpec(
                              labelStyle: new charts.TextStyleSpec(
                                fontSize: 14,
                                color: charts
                                    .MaterialPalette.blue.shadeDefault.darker,
                              ),
                              lineStyle: new charts.LineStyleSpec(
                                color: charts
                                    .MaterialPalette.blue.shadeDefault.darker,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 400,
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Column(
                    children: <Widget>[
                      Text("Tests Performed"),
                      Expanded(
                        child: charts.BarChart(
                          tests,
                          animate: true,
                          domainAxis: new charts.OrdinalAxisSpec(
                            renderSpec: new charts.SmallTickRendererSpec(
                              labelStyle: new charts.TextStyleSpec(
                                fontSize: 14,
                                color: charts
                                    .MaterialPalette.blue.shadeDefault.darker,
                              ),
                              lineStyle: new charts.LineStyleSpec(
                                color: charts
                                    .MaterialPalette.blue.shadeDefault.darker,
                              ),
                            ),
                          ),
                          primaryMeasureAxis: new charts.NumericAxisSpec(
                            renderSpec: new charts.GridlineRendererSpec(
                              labelStyle: new charts.TextStyleSpec(
                                fontSize: 14,
                                color: charts
                                    .MaterialPalette.blue.shadeDefault.darker,
                              ),
                              lineStyle: new charts.LineStyleSpec(
                                color: charts
                                    .MaterialPalette.blue.shadeDefault.darker,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
