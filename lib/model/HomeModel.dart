// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  String? title;
  List<Row>? rows;

  HomeModel({
    this.title,
    this.rows,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    title: json["title"],
    rows: json["rows"] == null ? [] : List<Row>.from(json["rows"]!.map((x) => Row.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "rows": rows == null ? [] : List<dynamic>.from(rows!.map((x) => x.toJson())),
  };
}

class Row {
  String? title;
  String? description;
  String? imageHref;

  Row({
    this.title,
    this.description,
    this.imageHref,
  });

  factory Row.fromJson(Map<String, dynamic> json) => Row(
    title: json["title"],
    description: json["description"],
    imageHref: json["imageHref"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "imageHref": imageHref,
  };
}