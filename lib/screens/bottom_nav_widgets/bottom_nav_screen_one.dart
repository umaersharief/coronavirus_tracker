import 'package:coronavirus_tracker/models/chart_model.dart';
import 'package:coronavirus_tracker/models/confirmed_chart.dart';
import 'package:coronavirus_tracker/services/daily_updates_service.dart';
import 'package:coronavirus_tracker/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:coronavirus_tracker/models/daily_updates_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_admob/firebase_admob.dart';

final Color backgroundColor = Color(0xff4a4a58);
final Color dashboardBackgroundColor = Colors.deepOrange;

class BottomNavigationScreenOne extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<BottomNavigationScreenOne>
    with SingleTickerProviderStateMixin {
  double screenWidth, screenHeight;

  //firebase admob
  MobileAdTargetingInfo targetingInfo;
  BannerAd myBanner;

  //banner ad unit id
  //'ca-app-pub-3716948913566119~2781912838'

  bool isColapsed = true;
  List<DailyUpdatesModel> _models;

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-3716948913566119~2781912838');
    targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['flutterio', 'beautiful apps'],
      contentUrl: 'https://flutter.io',
      childDirected: false,
    );

    myBanner = BannerAd(
      adUnitId: 'ca-app-pub-3716948913566119/4050724481',
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
    myBanner
  // typically this happens well before the ad is shown
  ..load()
  ..show(
    // Positions the banner ad 60 pixels from the bottom of the screen
    anchorOffset: 60.0,
    // Positions the banner ad 10 pixels from the center of the screen to the right
    horizontalCenterOffset: 10.0,
    // Banner Position
    anchorType: AnchorType.bottom,
  );

    DailyUpdatesService.getModel().then((model) {
      setState(() {
        _models = model;
      });
    });
  }

  List<ChartModel> getDataInList() {
    List<ChartModel> list = [];
    list = [
      for (var i = 0; i < _models.length; i++)
        ChartModel(
          totalConfirmed: _models[i].confirmed.total,
          reportDate: _models[i].reportDate,
          barColor: charts.ColorUtil.fromDartColor(appBar_icons_text_color),
        ),
    ];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    //local variables
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          home(context),
        ],
      ),
    );
  }

  Widget home(context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ConfirmedChart(data: getDataInList()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: secondaryColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/icons/confirmed.png',
                            color: appBar_icons_color,
                            height: 100.0,
                            width: 100.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text('Total Confirmed:'),
                        Text('$confirmed',
                            style: TextStyle(color: appBar_icons_text_color))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: secondaryColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/icons/recovered.png',
                            color: appBar_icons_color,
                            height: 100.0,
                            width: 100.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text('Total Recovered:'),
                        Text(
                          '$recovered',
                          style: TextStyle(color: appBar_icons_text_color),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: secondaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/deaths.png',
                            color: appBar_icons_color,
                            height: 100.0,
                            width: 100.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text('Total Deaths:'),
                        Text('$deaths',
                            style: TextStyle(color: appBar_icons_text_color))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: secondaryColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/icons/date.png',
                            color: appBar_icons_color,
                            height: 100.0,
                            width: 100.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text('Update Time:'),
                        Text('$lastUpdate',
                            style: TextStyle(color: appBar_icons_text_color)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
