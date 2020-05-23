import 'package:charts_flutter/flutter.dart' as charts;
import 'package:coronavirus_tracker/utils/app_utils.dart';
import 'package:flutter/material.dart';
//import 'china_chart_model.dart';
import 'china_deaths_chart_model.dart';
//import 'model.dart';
//import 'deaths_chart_model.dart';
//import 'package:auto_size_text/auto_size_text.dart';

class ChinaDeathsChart extends StatelessWidget {
  final List<ChinaDeathsChartModel> data;

  ChinaDeathsChart({@required this.data});

  DateTime getDate() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ChinaDeathsChartModel, String>> modelData = [
      charts.Series(
        id: 'ChinaChart',
        data: data,
        domainFn: (ChinaDeathsChartModel model, _) => model.reportDate.toString(),
        measureFn: (ChinaDeathsChartModel model, _) => model.deathsChina,
        colorFn: (ChinaDeathsChartModel model, _) => model.barColor,
      ),
      //colorFn: (Model model, _) => model.barColor,
    ];
    return Container(
      height: 400,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.elliptical(5.0, 3.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Center(
                child: RichText(
                  textDirection: TextDirection.ltr,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'China Deaths from\n',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: '22nd JAN ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: appBar_icons_text_color
                        ),
                      ),
                      TextSpan(
                        text: 'till\n',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: '$lastUpdate',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: appBar_icons_text_color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: charts.BarChart(
                  modelData,
                  animate: true,
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    renderSpec: charts.GridlineRendererSpec(
                      labelAnchor: charts.TickLabelAnchor.centered,
                      minimumPaddingBetweenLabelsPx: 1,
                    ),
                  ),
                  animationDuration: Duration(seconds: 10),
                  vertical: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
