import 'package:coronavirus_tracker/models/china_deaths_chart.dart';
import 'package:coronavirus_tracker/models/china_deaths_chart_model.dart';
import 'package:coronavirus_tracker/models/daily_updates_model.dart';
import 'package:coronavirus_tracker/models/deaths_chart.dart';
import 'package:coronavirus_tracker/models/recovered_chart_model.dart';
import 'package:coronavirus_tracker/services/daily_updates_service.dart';
import 'package:coronavirus_tracker/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:coronavirus_tracker/models/deaths_chart_model.dart';
import 'package:coronavirus_tracker/models/china_chart_model.dart';
import 'package:coronavirus_tracker/models/china_confirmed_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BottomNavigationScreenFour extends StatefulWidget {
  @override
  _BottomNavigationScreenFourState createState() => _BottomNavigationScreenFourState();
}

class _BottomNavigationScreenFourState extends State<BottomNavigationScreenFour> {
  List<DailyUpdatesModel> _dailyUpdatesModel;
  @override
  void initState() {
    super.initState();
    DailyUpdatesService.getModel().then((model) {
      setState(() {
        _dailyUpdatesModel = model;
      });
    });
  }
  List<DeathsChartModel> getDeathsDataInList() {
    List<DeathsChartModel> list = [];
    list = [
      for (var i = 0; i < _dailyUpdatesModel.length; i++)
        DeathsChartModel(
          totalDeaths: _dailyUpdatesModel[i].deaths.total,
          reportDate: _dailyUpdatesModel[i].reportDate,
          barColor: charts.ColorUtil.fromDartColor(appBar_icons_text_color),
        ),
    ];
    return list;
  }


  List<RecoveredChartModel> getRecoveredDataInList() {
    List<RecoveredChartModel> list = [];
    list = [
      for (var i = 0; i < _dailyUpdatesModel.length; i++)
        RecoveredChartModel(
          totalrecovered: _dailyUpdatesModel[i].recovered.total,
          reportDate: _dailyUpdatesModel[i].reportDate,
          barColor: charts.ColorUtil.fromDartColor(appBar_icons_text_color),
        ),
    ];
    return list;
  }

  List<ChinaChartModel> getChinaDataInList() {
    List<ChinaChartModel> list = [];
    list = [
      for (var i = 0; i < _dailyUpdatesModel.length; i++)
        ChinaChartModel(
          mainlandChina: _dailyUpdatesModel[i].mainlandChina,
          reportDate: _dailyUpdatesModel[i].reportDate,
          barColor: charts.ColorUtil.fromDartColor(appBar_icons_text_color),
        ),
    ];
    return list;
  }

  List<ChinaDeathsChartModel> getChinaDeathsDataInList() {
    List<ChinaDeathsChartModel> list = [];
    list = [
      for (var i = 0; i < _dailyUpdatesModel.length; i++)
        ChinaDeathsChartModel(
          deathsChina: _dailyUpdatesModel[i].deaths.china,
          reportDate: _dailyUpdatesModel[i].reportDate,
          barColor: charts.ColorUtil.fromDartColor(appBar_icons_text_color),
        ),
    ];
    return list;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DeathChart(data: getDeathsDataInList()),
            //RecoveredChart(data: getRecoveredDataInList()),
            ChinaConfirmedChart(data: getChinaDataInList()),
            ChinaDeathsChart(data: getChinaDeathsDataInList(),),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}