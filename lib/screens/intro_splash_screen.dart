import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:coronavirus_tracker/screens/internet_test_screen.dart';

class IntroSplashScreen extends StatelessWidget {
  static const routeName = '/introScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 200),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Lottie.asset(
                          'assets/lottie_anim/health_worker.json',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Stay Home Save Lives',
                          style: TextStyle(
                            color: Color(0xF0F0ff40),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 8.0,
                        color: Colors.grey.shade800,
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade100,
                        Colors.blue.shade700,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, InternetTestScreen.routeName);
                    },
                    child: Text('Next'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
