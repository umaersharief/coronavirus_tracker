import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
//import 'model.dart';

class DeathsChartModel {
  final DateTime reportDate;
  final int totalDeaths;
  final charts.Color barColor;

  DeathsChartModel(
      {@required this.reportDate,
      @required this.totalDeaths,
      @required this.barColor});
}