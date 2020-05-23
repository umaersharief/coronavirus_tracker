import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
//import 'model.dart';

class RecoveredChartModel {
  final DateTime reportDate;
  final int totalrecovered;
  final charts.Color barColor;

  RecoveredChartModel(
      {@required this.reportDate,
      @required this.totalrecovered,
      @required this.barColor});
}