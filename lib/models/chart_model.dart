import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
//import 'model.dart';

class ChartModel {
  final DateTime reportDate;
  final int totalConfirmed;
  final charts.Color barColor;

  ChartModel(
      {@required this.reportDate,
      @required this.totalConfirmed,
      @required this.barColor});
}