// To parse this JSON data, do
//
//     final dailyUpdatesModel = dailyUpdatesModelFromJson(jsonString);

import 'dart:convert';

List<DailyUpdatesModel> dailyUpdatesModelFromJson(String str) => List<DailyUpdatesModel>.from(json.decode(str).map((x) => DailyUpdatesModel.fromJson(x)));

String dailyUpdatesModelToJson(List<DailyUpdatesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailyUpdatesModel {
    int totalConfirmed;
    int mainlandChina;
    int otherLocations;
    int deltaConfirmed;
    int totalRecovered;
    Confirmed confirmed;
    Confirmed deltaConfirmedDetail;
    Confirmed deaths;
    Confirmed recovered;
    int active;
    int deltaRecovered;
    double incidentRate;
    int peopleTested;
    DateTime reportDate;

    DailyUpdatesModel({
        this.totalConfirmed,
        this.mainlandChina,
        this.otherLocations,
        this.deltaConfirmed,
        this.totalRecovered,
        this.confirmed,
        this.deltaConfirmedDetail,
        this.deaths,
        this.recovered,
        this.active,
        this.deltaRecovered,
        this.incidentRate,
        this.peopleTested,
        this.reportDate,
    });

    factory DailyUpdatesModel.fromJson(Map<String, dynamic> json) => DailyUpdatesModel(
        totalConfirmed: json["totalConfirmed"],
        mainlandChina: json["mainlandChina"],
        otherLocations: json["otherLocations"],
        deltaConfirmed: json["deltaConfirmed"],
        totalRecovered: json["totalRecovered"],
        confirmed: Confirmed.fromJson(json["confirmed"]),
        deltaConfirmedDetail: Confirmed.fromJson(json["deltaConfirmedDetail"]),
        deaths: Confirmed.fromJson(json["deaths"]),
        recovered: Confirmed.fromJson(json["recovered"]),
        active: json["active"],
        deltaRecovered: json["deltaRecovered"],
        incidentRate: json["incidentRate"].toDouble(),
        peopleTested: json["peopleTested"],
        reportDate: DateTime.parse(json["reportDate"]),
    );

    Map<String, dynamic> toJson() => {
        "totalConfirmed": totalConfirmed,
        "mainlandChina": mainlandChina,
        "otherLocations": otherLocations,
        "deltaConfirmed": deltaConfirmed,
        "totalRecovered": totalRecovered,
        "confirmed": confirmed.toJson(),
        "deltaConfirmedDetail": deltaConfirmedDetail.toJson(),
        "deaths": deaths.toJson(),
        "recovered": recovered.toJson(),
        "active": active,
        "deltaRecovered": deltaRecovered,
        "incidentRate": incidentRate,
        "peopleTested": peopleTested,
        "reportDate": "${reportDate.year.toString().padLeft(4, '0')}-${reportDate.month.toString().padLeft(2, '0')}-${reportDate.day.toString().padLeft(2, '0')}",
    };
}

class Confirmed {
    int total;
    int china;
    int outsideChina;

    Confirmed({
        this.total,
        this.china,
        this.outsideChina,
    });

    factory Confirmed.fromJson(Map<String, dynamic> json) => Confirmed(
        total: json["total"],
        china: json["china"],
        outsideChina: json["outsideChina"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "china": china,
        "outsideChina": outsideChina,
    };
}
