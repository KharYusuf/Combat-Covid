import 'package:Combat_Covid/models/scrappedData.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:Combat_Covid/providers/stats.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  _getCases(list) {
    List<ScrapedData> cases = [
      ScrapedData(DateTime.now().add(new Duration(days: -6)),
          int.parse(list.elementAt(list.length - 21)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -5)),
          int.parse(list.elementAt(list.length - 18)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -4)),
          int.parse(list.elementAt(list.length - 15)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -3)),
          int.parse(list.elementAt(list.length - 12)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -2)),
          int.parse(list.elementAt(list.length - 9)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -1)),
          int.parse(list.elementAt(list.length - 6)['Total'])),
      ScrapedData(
          DateTime.now(), int.parse(list.elementAt(list.length - 3)['Total'])),
    ];
    return cases;
  }

  _getRecovered(list) {
    List<ScrapedData> recoveries = [
      ScrapedData(DateTime.now().add(new Duration(days: -6)),
          int.parse(list.elementAt(list.length - 20)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -5)),
          int.parse(list.elementAt(list.length - 17)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -4)),
          int.parse(list.elementAt(list.length - 14)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -3)),
          int.parse(list.elementAt(list.length - 11)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -2)),
          int.parse(list.elementAt(list.length - 8)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -1)),
          int.parse(list.elementAt(list.length - 5)['Total'])),
      ScrapedData(
          DateTime.now(), int.parse(list.elementAt(list.length - 2)['Total'])),
    ];

    return recoveries;
  }

  _getDeaths(list) {
    List<ScrapedData> deaths = [
      ScrapedData(DateTime.now().add(new Duration(days: -6)),
          int.parse(list.elementAt(list.length - 19)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -5)),
          int.parse(list.elementAt(list.length - 16)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -4)),
          int.parse(list.elementAt(list.length - 13)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -3)),
          int.parse(list.elementAt(list.length - 10)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -2)),
          int.parse(list.elementAt(list.length - 7)['Total'])),
      ScrapedData(DateTime.now().add(new Duration(days: -1)),
          int.parse(list.elementAt(list.length - 4)['Total'])),
      ScrapedData(
          DateTime.now(), int.parse(list.elementAt(list.length - 1)['Total'])),
    ];

    return deaths;
  }

  @override
  Widget build(BuildContext context) {
    _getData() async {
      Iterable<Map<String, dynamic>> list =
          await Provider.of<Stats>(context).getCases();
      Map<int, List<ScrapedData>> values = Map();
      values[0] = _getCases(list);
      values[1] = _getRecovered(list);
      values[2] = _getDeaths(list);
      return values;
    }

    return new Scaffold(
        appBar: AppBar(
          title: Text("Statistics"),
        ),
        body: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<charts.Series<ScrapedData, String>> newCases = [
                charts.Series(
                  id: "Cases",
                  data: snapshot.data[0],
                  domainFn: (ScrapedData series, _) =>
                      DateFormat('dd-MM').format(series.date),
                  measureFn: (ScrapedData series, _) => series.cases,
                  colorFn: (ScrapedData series, _) =>
                      charts.ColorUtil.fromDartColor(Colors.blue),
                )
              ];
              List<charts.Series<ScrapedData, String>> recover = [
                charts.Series(
                  id: "Cases",
                  data: snapshot.data[1],
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
                  data: snapshot.data[2],
                  domainFn: (ScrapedData series, _) =>
                      DateFormat('dd-MM').format(series.date),
                  measureFn: (ScrapedData series, _) => series.cases,
                  colorFn: (ScrapedData series, _) =>
                      charts.ColorUtil.fromDartColor(Colors.blue),
                )
              ];
              return SingleChildScrollView(
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
                                  newCases,
                                  animate: true,
                                  domainAxis: new charts.OrdinalAxisSpec(
                                    renderSpec:
                                        new charts.SmallTickRendererSpec(
                                      labelStyle: new charts.TextStyleSpec(
                                        fontSize: 14,
                                        color: charts.MaterialPalette.blue
                                            .shadeDefault.darker,
                                      ),
                                      lineStyle: new charts.LineStyleSpec(
                                        color: charts.MaterialPalette.blue
                                            .shadeDefault.darker,
                                      ),
                                    ),
                                  ),
                                  primaryMeasureAxis:
                                      new charts.NumericAxisSpec(
                                    renderSpec: new charts.GridlineRendererSpec(
                                      labelStyle: new charts.TextStyleSpec(
                                        fontSize: 14,
                                        color: charts.MaterialPalette.blue
                                            .shadeDefault.darker,
                                      ),
                                      lineStyle: new charts.LineStyleSpec(
                                        color: charts.MaterialPalette.blue
                                            .shadeDefault.darker,
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
                              Text("Recoveries"),
                              Expanded(
                                child: charts.BarChart(
                                  recover,
                                  animate: true,
                                  domainAxis: new charts.OrdinalAxisSpec(
                                    renderSpec:
                                        new charts.SmallTickRendererSpec(
                                      labelStyle: new charts.TextStyleSpec(
                                        fontSize: 14,
                                        color: charts.MaterialPalette.blue
                                            .shadeDefault.darker,
                                      ),
                                      lineStyle: new charts.LineStyleSpec(
                                        color: charts.MaterialPalette.blue
                                            .shadeDefault.darker,
                                      ),
                                    ),
                                  ),
                                  primaryMeasureAxis:
                                      new charts.NumericAxisSpec(
                                    renderSpec: new charts.GridlineRendererSpec(
                                      labelStyle: new charts.TextStyleSpec(
                                        fontSize: 14,
                                        color: charts.MaterialPalette.blue
                                            .shadeDefault.darker,
                                      ),
                                      lineStyle: new charts.LineStyleSpec(
                                        color: charts.MaterialPalette.blue
                                            .shadeDefault.darker,
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
                              Text("Deaths"),
                              Expanded(
                                child: charts.BarChart(
                                  deaths,
                                  animate: true,
                                  domainAxis: new charts.OrdinalAxisSpec(
                                    renderSpec:
                                        new charts.SmallTickRendererSpec(
                                      labelStyle: new charts.TextStyleSpec(
                                        fontSize: 14,
                                        color: charts.MaterialPalette.blue
                                            .shadeDefault.darker,
                                      ),
                                      lineStyle: new charts.LineStyleSpec(
                                        color: charts.MaterialPalette.blue
                                            .shadeDefault.darker,
                                      ),
                                    ),
                                  ),
                                  primaryMeasureAxis:
                                      new charts.NumericAxisSpec(
                                    renderSpec: new charts.GridlineRendererSpec(
                                      labelStyle: new charts.TextStyleSpec(
                                        fontSize: 14,
                                        color: charts.MaterialPalette.blue
                                            .shadeDefault.darker,
                                      ),
                                      lineStyle: new charts.LineStyleSpec(
                                        color: charts.MaterialPalette.blue
                                            .shadeDefault.darker,
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
              );
            }
          },
        ));
  }
}
