import 'package:coronavirus_tracker/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class BottomNavigationScreenThree extends StatefulWidget {

  @override
  _BottomNavigationScreenThreeState createState() =>
      _BottomNavigationScreenThreeState();
}

class _BottomNavigationScreenThreeState
    extends State<BottomNavigationScreenThree> {
  String _countryName;
  String _countryCode;
  String _newConfirmed;
  String _totalConfirmed;
  String _newDeaths;
  String _totalDeaths;
  String _newRecovered;
  String _totalRecovered;
  String _date;

  final String url = 'https://api.covid19api.com/summary';
  String _flagImgSrc =
      'https://raw.githubusercontent.com/hjnilsson/country-flags/master/png250px/af.png';
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
    setState(() {
      var convertDataToJson = json.decode(response.body);
      countries = convertDataToJson['Countries'];
      for (int i = 0; i < countries.length; i++) {
        if (countries[i]['Country'].toString() == 'Pakistan') {
          _countryName = countries[i]["Country"];
          _countryCode = countries[i]["CountryCode"];
          _newConfirmed = countries[i]["NewConfirmed"].toString();
          _totalConfirmed = countries[i]["TotalConfirmed"].toString();
          _newDeaths = countries[i]["NewDeaths"].toString();
          _totalDeaths = countries[i]["TotalDeaths"].toString();
          _newRecovered = countries[i]["NewRecovered"].toString();
          _totalRecovered = countries[i]["TotalRecovered"].toString();
          _date = countries[i]["Date"].toString();
        }
      }
    });
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: _flagImgSrc.replaceAll(
                            new RegExp(r'af'), 'PK'.toLowerCase()),
                        imageBuilder: (context, imageProvider) => Center(
                          child: Image(
                            image: imageProvider,
                          ),
                        ),
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black54,
                            strokeWidth: 2.0,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 3/2,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/pakistan_map.png',
                      height: 100,
                      width: 100,
                      color: appBar_icons_color,
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Country Name:'),
                        Text(
                          _countryName,
                          style: TextStyle(color: appBar_icons_text_color),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Country Code:'),
                        Text(
                          _countryCode,
                          style: TextStyle(color: appBar_icons_text_color),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('New Confirmed Cases:'),
                        Text(
                          _newConfirmed,
                          style: TextStyle(color: appBar_icons_text_color),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('New Deaths:'),
                        Text(
                          _newDeaths,
                          style: TextStyle(color: appBar_icons_text_color),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('New Recovered:'),
                        Text(
                          _newRecovered,
                          style: TextStyle(color: appBar_icons_text_color),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total Recovered:'),
                        Text(
                          _totalRecovered,
                          style: TextStyle(color: appBar_icons_text_color),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total Deaths:'),
                        Text(
                          _totalDeaths,
                          style: TextStyle(color: appBar_icons_text_color),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total Confirmed Cases:'),
                        Text(
                          _totalConfirmed,
                          style: TextStyle(color: appBar_icons_text_color),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            flex: 1, child: Text('Last Update Date & time:')),
                        Expanded(
                          flex: 1,
                          child: Text(
                            _date,
                            style: TextStyle(color: appBar_icons_text_color),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
