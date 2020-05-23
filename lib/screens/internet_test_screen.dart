import 'package:coronavirus_tracker/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:coronavirus_tracker/utils/app_utils.dart';
import 'package:coronavirus_tracker/screens/dashboard.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class InternetTestScreen extends StatefulWidget {
  static const routeName = '/internetTestScreen';
  @override
  _InternetTestScreenState createState() => _InternetTestScreenState();
}

class _InternetTestScreenState extends State<InternetTestScreen> {
  String dummName = 'umair';
  final String url = 'https://covid19.mathdro.id/api/';
  //final String dailyDeathsURL = 'https://covid19.mathdro.id/api/daily';
  bool isOnline = false;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<Object> getJsonData() async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"},
    );
    setState(() {
      if (response.toString().isNotEmpty) {
        isOnline = true;
        dummName = 'uzair';
        var convertDataToJson = json.decode(response.body);
        confirmed = convertDataToJson['confirmed']['value'];
        recovered = convertDataToJson['recovered']['value'];
        deaths = convertDataToJson['deaths']['value'];
        lastUpdate = convertDataToJson['lastUpdate'];
      }
    });
    print('internet test deaths: $deaths');
    print('internet test confirmed: $confirmed');
    print('internet test recovered: $recovered');
    print('internet test lastUpdate: $lastUpdate');
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: (isOnline)
              ? Navigator.pushNamed(
                  context,
                  Dashboard.routeName,
                )
              : LoadingScreen(),
        ),
      ),
    );
  }
}
