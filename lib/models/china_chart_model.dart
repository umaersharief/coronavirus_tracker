import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
//import 'model.dart';

class ChinaChartModel {
  final DateTime reportDate;
  final int mainlandChina;
  final charts.Color barColor;

  ChinaChartModel(
      {@required this.reportDate,
      @required this.mainlandChina,
      @required this.barColor});
}