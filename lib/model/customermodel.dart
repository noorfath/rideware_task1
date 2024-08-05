// customermodel.dart
import 'dart:convert';

class Customermodel {
  bool isValid;
  String message;
  List<Datum> data;

  Customermodel({
    required this.isValid,
    required this.message,
    required this.data,
  });

  factory Customermodel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Datum> dataList = list.map((i) => Datum.fromJson(i)).toList();
    return Customermodel(
      isValid: json['isValid'],
      message: json['message'],
      data: dataList,
    );
  }
}

class Datum {
  int custId;
  String name;
  int routeId;

  Datum({
    required this.custId,
    required this.name,
    required this.routeId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      custId: json['custId'],
      name: json['name'],
      routeId: json['routeId'],
    );
  }
}

class ApiResponse {
  bool isValid;
  String message;
  List<Routes> data;

  ApiResponse({
    required this.isValid,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Routes> dataList = list.map((i) => Routes.fromJson(i)).toList();
    return ApiResponse(
      isValid: json['isValid'],
      message: json['message'],
      data: dataList,
    );
  }
}

class Routes {
  int routeId;
  String name;

  Routes({
    required this.routeId,
    required this.name,
  });

  factory Routes.fromJson(Map<String, dynamic> json) {
    return Routes(
      routeId: json['routeId'],
      name: json['name'],
    );
  }
}
