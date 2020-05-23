import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
//import 'model.dart';

class ChinaDeathsChartModel {
  final DateTime reportDate;
  final int deathsChina;
  final charts.Color barColor;

  ChinaDeathsChartModel(
      {@required this.reportDate,
      @required this.deathsChina,
      @required this.barColor});
}