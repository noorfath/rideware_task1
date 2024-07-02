// To parse this JSON data, do
//
//     final cakelistmodel = cakelistmodelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Cakelistmodel cakelistmodelFromJson(String str) => Cakelistmodel.fromJson(json.decode(str));

String cakelistmodelToJson(Cakelistmodel data) => json.encode(data.toJson());

class Cakelistmodel {
    bool isValid;
    String message;
    List<Datumm> data;

    Cakelistmodel({
        required this.isValid,
        required this.message,
        required this.data,
    });

    factory Cakelistmodel.fromJson(Map<String, dynamic> json) => Cakelistmodel(
        isValid: json["isValid"],
        message: json["message"],
        data: List<Datumm>.from(json["data"].map((x) => Datumm.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isValid": isValid,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datumm {
    int itemId;
    int categoryId;
    String name;
    String arabicName;
    String description;
    String itemcode;
    String type;
    int price;
    String imgurl;

    Datumm({
        required this.itemId,
        required this.categoryId,
        required this.name,
        required this.arabicName,
        required this.description,
        required this.itemcode,
        required this.type,
        required this.price,
        required this.imgurl,
    });

    factory Datumm.fromJson(Map<String, dynamic> json) => Datumm(
        itemId: json["itemId"],
        categoryId: json["categoryId"],
        name: json["name"],
        arabicName: json["arabicName"],
        description: json["description"],
        itemcode: json["itemcode"],
        type: json["type"],
        price: json["price"],
        imgurl: json["imgurl"],
    );

    Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "categoryId": categoryId,
        "name": name,
        "arabicName": arabicName,
        "description": description,
        "itemcode": itemcode,
        "type": type,
        "price": price,
        "imgurl": imgurl,
    };
}
