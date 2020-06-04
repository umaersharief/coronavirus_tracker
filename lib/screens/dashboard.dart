//import 'package:cached_network_image/cached_network_image.dart';
import 'package:coronavirus_tracker/screens/bottom_nav_widgets/bottom_nav_screen_one.dart';
import 'package:coronavirus_tracker/screens/bottom_nav_widgets/bottom_nav_screen_two.dart';
import 'package:coronavirus_tracker/screens/bottom_nav_widgets/bottom_nav_screen_three.dart';
import 'package:coronavirus_tracker/screens/bottom_nav_widgets/bottom_nav_screen_four.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:coronavirus_tracker/utils/app_utils.dart';

final Color backgroundColor = Color(0xff4a4a58);
final Color dashboardBackgroundColor = Colors.deepOrange;

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
      


      //firebase admob
  MobileAdTargetingInfo targetingInfo;
  InterstitialAd myInterstitial;



  double screenWidth, screenHeight;
  bool isColapsed = true;
  bool menuItemOneTapped = false;
  bool menuItemTwoTapped = false;
  bool menuItemThreeTapped = false;
  bool menuItemFourTapped = false;
  bool menuItemFiveTapped = false;
  Color selectedIconColor = appBar_icons_color;
  Color unSelectedIconColor = primaryColor;
  int _currentIndex = 0;
  final List<Widget> _children = [
    BottomNavigationScreenOne(),
    BottomNavigationScreenTwo(),
    BottomNavigationScreenThree(),
    BottomNavigationScreenFour(),
  ];

  final Duration slideAnimationDuration = const Duration(milliseconds: 1000);
  AnimationController _animationController;
  Animation<Offset> _slideAnimation;
  
  //Interstitial ad unit id
  //'ca-app-pub-3716948913566119~2781912838'

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-3716948913566119~2781912838');

    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  childDirected: false,
);

    myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  //'ca-app-pub-3716948913566119/9550501166'
  adUnitId: 'ca-app-pub-3716948913566119/7777737579',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

    _animationController = AnimationController(
      vsync: this,
      duration: slideAnimationDuration,
    );
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(0.5, 0))
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //ad show
  void _showInterstitialAd(){
    myInterstitial
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
          menu(context),
          home(context),
        ],
      ),
    );
  }

  Widget home(context) {
    return AnimatedPositioned(
      duration: slideAnimationDuration,
      top: 0,
      bottom: 0,
      left: isColapsed ? 0 : 0.2 * screenWidth,
      right: isColapsed ? 0 : -0.2 * screenWidth,
      child: SlideTransition(
        position: _slideAnimation,
        child: Material(
          animationDuration: slideAnimationDuration,
          borderRadius: isColapsed
              ? BorderRadius.circular(0)
              : BorderRadius.all(Radius.circular(40)),
          elevation: 5,
          color: dashboardBackgroundColor,
          child: Scaffold(
            appBar: AppBar(
              elevation: 8.0,
              centerTitle: true,
              primary: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                side: BorderSide.none,
              ),
              backgroundColor: primaryColor,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  print('onPressed Clicked');
                  _showInterstitialAd();
                  if (isColapsed) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                  setState(() {
                    isColapsed = !isColapsed;
                  });
                },
              ),
              title: Text('Corornavirus Tracker'),
            ),
            body: _children[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: appBar_icons_text_color,
              elevation: 8.0,
              unselectedIconTheme: IconThemeData(
                color: appBar_icons_color,
              ),
              type: BottomNavigationBarType.shifting,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/world.png',
                    width: 30,
                    height: 30,
                    color: _currentIndex == 0 ? selectedIconColor: unSelectedIconColor,
                  ),
                  title: Text("World"),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/list.png',
                    width: 30,
                    height: 30,
                    color: _currentIndex == 1 ? selectedIconColor: unSelectedIconColor,
                  ),
                  title: Text("All Countries"),
                ),
                BottomNavigationBarItem(
                  icon: 
                  Image.asset(
                    'assets/icons/pakistan_flag.png',
                    width: 30,
                    height: 30,
                  ),
                  title: Text("Pakistan"),
                ),
                BottomNavigationBarItem(
                  icon: 
                  Image.asset(
                    'assets/icons/graph.png',
                    width: 30,
                    height: 30,
                    color: _currentIndex == 3 ? selectedIconColor: unSelectedIconColor,
                  ),
                  title: Text("Graphs"),
                ),
              ],
              onTap: onTabTapped,
            ),
          ),
        ),
      ),
    );
  }

  Widget menu(context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(top: 28, left: 10),
            child:   Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'assets/icons/ic_launcher.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          ),
          SizedBox(height: 50),
          // GestureDetector(
          //   onTap: () {
          //     setState(() {
          //       menuItemOneTapped = true;
          //       menuItemTwoTapped = false;
          //       menuItemThreeTapped = false;
          //       menuItemFourTapped = false;
          //       menuItemFiveTapped = false;
          //     });
          //   },
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     width: 400,
          //     height: 100,
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: RichText(
          //         text: TextSpan(
          //             style: TextStyle(color: appBar_icons_text_color),
          //             text: """Coronavirus disease (COVID-19) is an infectious 
          //           disease caused by a newly discovered coronavirus. Most 
          //           people who fall sick with COVID-19 will experience mild 
          //           to moderate symptoms and recover without special treatment."""),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 5),
          Divider(),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              setState(() {
                menuItemOneTapped = false;
                menuItemTwoTapped = true;
                menuItemThreeTapped = false;
                menuItemFourTapped = false;
                menuItemFiveTapped = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_circle_outline),
                    SizedBox(width: 10),
                    Text(
                      "Clean your hands with \nSoap regularly",
                      style: TextStyle(
                        color: appBar_icons_text_color,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Divider(),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              setState(() {
                menuItemOneTapped = false;
                menuItemTwoTapped = false;
                menuItemThreeTapped = true;
                menuItemFourTapped = false;
                menuItemFiveTapped = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_circle_outline),
                    SizedBox(width: 10),
                    Text(
                      "Maintain at least \n3 feet distance from others",
                      style: TextStyle(
                        color: appBar_icons_text_color,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Divider(),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              setState(() {
                menuItemOneTapped = false;
                menuItemTwoTapped = false;
                menuItemThreeTapped = false;
                menuItemFourTapped = true;
                menuItemFiveTapped = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_circle_outline),
                    SizedBox(width: 10),
                    Text(
                      "Wear Masks and gloves\nwhen going outside",
                      style: TextStyle(
                        color: appBar_icons_text_color,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Divider(),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              setState(() {
                menuItemOneTapped = false;
                menuItemTwoTapped = false;
                menuItemThreeTapped = false;
                menuItemFourTapped = false;
                menuItemFiveTapped = true;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_circle_outline),
                    SizedBox(width: 10),
                    Text(
                      "Avoid Touching your eyes, \nnose & mouth",
                      style: TextStyle(
                        color: appBar_icons_text_color,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Divider(),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              setState(() {
                menuItemOneTapped = false;
                menuItemTwoTapped = false;
                menuItemThreeTapped = false;
                menuItemFourTapped = false;
                menuItemFiveTapped = true;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_circle_outline),
                    SizedBox(width: 10),
                    Text(
                      "Stay home and self-isolate",
                      style: TextStyle(
                        color: appBar_icons_text_color,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Divider(),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              setState(() {
                menuItemOneTapped = false;
                menuItemTwoTapped = false;
                menuItemThreeTapped = false;
                menuItemFourTapped = false;
                menuItemFiveTapped = true;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_circle_outline),
                    SizedBox(width: 10),
                    Text(
                      "Seek Medical Attention\nif you have a fever, cough \nand difficulty breathing",
                      style: TextStyle(
                        color: appBar_icons_text_color,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
}
