import 'package:flutter/widgets.dart';
import '../models/scrappedData.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Stats with ChangeNotifier {
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

  Future<Iterable<Map<String, dynamic>>> getCases() async {
    String link = 'https://api.covid19india.org/states_daily.json';
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    var data = await json.decode(res.body);
    var statesDaily = await data["states_daily"] as List;
    var list = statesDaily.map(
      (e) => {
        'status': e['status'],
        'date': e['dateymd'],
        'Andaman and Nicobar': e['an'],
        'Andhra Pradesh': e['ap'],
        'Arunachal Pradesh': e['ar'],
        'Assam': e['as'],
        'Bihar': e['br'],
        'Chandigarh': e['ch'],
        'Chattisgarh': e['ct'],
        'Daman and Diu': e['dd'],
        'Delhi': e['dl'],
        'Dadar and Nagar Haveli': e['dn'],
        'Goa': e['ga'],
        'Gujarat': e['gj'],
        'Himachal Pradesh': e['hp'],
        'Haryana': e['hr'],
        'Jharkhand': e['jh'],
        'Jammu and Kashmir': e['jk'],
        'Karnataka': e['ka'],
        'Kerela': e['kl'],
        'Ladakh': e['la'],
        'lakshwadeep': e['ld'],
        'Maharashtra': e['mh'],
        'Manipur': e['mn'],
        'Meghalaya': e['ml'],
        'Madhya Pradesh': e['mp'],
        'Mizoram': e['mz'],
        'Nagaland': e['nl'],
        'Orissa': e['or'],
        'Punjab': e['pb'],
        'Pondicherry': e['py'],
        'Rajasthan': e['rj'],
        'Sikkim': e['sk'],
        'Telangana': e['tg'],
        'Tamil Nadu': e['tn'],
        'Tripura': e['tr'],
        'Total': e['tt'],
        'Uttar Pradesh': e['up'],
        'Uttrakhand': e['ut'],
        'West Bengal': e['wb'],
      },
    );
    return list;
  }

  getDeaths() async {
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
    return deaths;
  }

  getTests() async {
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
    return tests;
  }
}
