import 'package:flutter/material.dart';
import 'package:coronavirus_tracker/utils/app_utils.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  static const routeName = '/loadingScreen';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Lottie.asset(
                  'assets/lottie_anim/lottie_wifi.json',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: RichText(
                        textDirection: TextDirection.ltr,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Please wait a few seconds for the Data to Load\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: appBar_icons_text_color,
                              ),
                            ),
                            TextSpan(
                              text: '.......................\n\n',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: appBar_icons_text_color),
                            ),
                            TextSpan(
                              text: 'It depends on your internet Connection!\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: appBar_icons_text_color,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'If you don\'t see anything after a few moments then either your internet is down or our servers are not responding. In either case try again in a few moments!',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: appBar_icons_text_color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
