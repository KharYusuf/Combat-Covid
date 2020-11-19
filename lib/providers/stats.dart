import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Stats with ChangeNotifier {
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
}
