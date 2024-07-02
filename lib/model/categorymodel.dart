// To parse this JSON data, do
//
//     final categorymodel = categorymodelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Categorymodel categorymodelFromJson(String str) => Categorymodel.fromJson(json.decode(str));

String categorymodelToJson(Categorymodel data) => json.encode(data.toJson());

class Categorymodel {
    bool isValid;
    String message;
    List<Datum> data;

    Categorymodel({
        required this.isValid,
        required this.message,
        required this.data,
    });

    factory Categorymodel.fromJson(Map<String, dynamic> json) => Categorymodel(
        isValid: json["isValid"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isValid": isValid,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int categoryId;
    String name;
    String arabicname;
    String description;

    Datum({
        required this.categoryId,
        required this.name,
        required this.arabicname,
        required this.description,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        categoryId: json["categoryId"],
        name: json["name"],
        arabicname: json["arabicname"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "name": name,
        "arabicname": arabicname,
        "description": description,
    };
}
