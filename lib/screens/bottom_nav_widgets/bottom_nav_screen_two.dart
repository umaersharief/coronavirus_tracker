import 'package:cached_network_image/cached_network_image.dart';
import 'package:coronavirus_tracker/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BottomNavigationScreenTwo extends StatefulWidget {

  @override
  _BottomNavigationScreenTwoState createState() =>
      _BottomNavigationScreenTwoState();
}

class _BottomNavigationScreenTwoState extends State<BottomNavigationScreenTwo> {
  final String url = 'https://api.covid19api.com/summary';
  String _flagImgSrc =
      'https://raw.githubusercontent.com/hjnilsson/country-flags/master/png100px/af.png';
  List countries;
  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<Object> getJsonData() async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"},
    );
    //print(response.body);
    if (this.mounted) {
      setState(() {
        var convertDataToJson = json.decode(response.body);
        countries = convertDataToJson['Countries'];
      });
    }
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: MediaQuery.of(context).size,
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: countries == null ? 0 : countries.length,
              itemBuilder: (BuildContext context, var index) {
                return Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Card(
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    countries[index]['Country'],
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    countries[index]['TotalConfirmed']
                                        .toString(),
                                    style: TextStyle(
                                      color: appBar_icons_color,
                                    ),
                                  ),
                                ),
                                CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: _flagImgSrc.replaceAll(
                                      new RegExp(r'af'),
                                      countries[index]['CountryCode']
                                          .toLowerCase()),
                                  imageBuilder: (context, imageProvider) =>
                                      Center(
                                    child: Image(
                                      image: imageProvider,
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.black54,
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
