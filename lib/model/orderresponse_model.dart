// order_response.dart
import 'dart:convert';

OrderResponse orderResponseFromJson(String str) => OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
  OrderResponse({
    required this.isValid,
    required this.message,
    required this.data,
  });

  bool isValid;
  String message;
  OrderData data;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
    isValid: json["isValid"],
    message: json["message"],
    data: OrderData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "isValid": isValid,
    "message": message,
    "data": data.toJson(),
  };
}

class OrderData {
  OrderData({
    required this.soId,
    required this.date,
    required this.orderType,
    required this.cretedBy,
    required this.cretedByName,
    required this.tableNo,
    required this.payStatus,
    required this.paymentType,
    required this.noItems,
    required this.total,
    required this.discount,
    required this.totAfterDisc,
    required this.vat,
    required this.totalAfterVat,
    required this.amountRecieved,
    required this.changeGiven,
    required this.customerId,
    required this.deliveryStatus,
    required this.delieveryTime,
    required this.deliveryPerson,
    required this.remarks,
    required this.isDelivered,
    required this.isConfirmed,
    required this.isPaid,
    required this.isDeleted,
  });

  int soId;
  DateTime date;
  String orderType;
  int cretedBy;
  String cretedByName;
  String tableNo;
  String payStatus;
  String paymentType;
  int noItems;
  double total;
  double discount;
  double totAfterDisc;
  double vat;
  double totalAfterVat;
  double amountRecieved;
  double changeGiven;
  int customerId;
  String deliveryStatus;
  DateTime delieveryTime;
  int deliveryPerson;
  String remarks;
  bool isDelivered;
  bool isConfirmed;
  bool isPaid;
  bool isDeleted;

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    soId: json["soId"],
    date: DateTime.parse(json["date"]),
    orderType: json["orderType"],
    cretedBy: json["cretedBy"],
    cretedByName: json["cretedByName"],
    tableNo: json["tableNo"],
    payStatus: json["payStatus"],
    paymentType: json["paymentType"],
    noItems: json["noItems"],
    total: json["total"].toDouble(),
    discount: json["discount"].toDouble(),
    totAfterDisc: json["totAfterDisc"].toDouble(),
    vat: json["vat"].toDouble(),
    totalAfterVat: json["totalAfterVat"].toDouble(),
    amountRecieved: json["amountRecieved"].toDouble(),
    changeGiven: json["changeGiven"].toDouble(),
    customerId: json["customerId"],
    deliveryStatus: json["deliveryStatus"],
    delieveryTime: DateTime.parse(json["delieveryTime"]),
    deliveryPerson: json["deliveryPerson"],
    remarks: json["remarks"],
    isDelivered: json["isDelivered"],
    isConfirmed: json["isConfirmed"],
    isPaid: json["isPaid"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "soId": soId,
    "date": date.toIso8601String(),
    "orderType": orderType,
    "cretedBy": cretedBy,
    "cretedByName": cretedByName,
    "tableNo": tableNo,
    "payStatus": payStatus,
    "paymentType": paymentType,
    "noItems": noItems,
    "total": total,
    "discount": discount,
    "totAfterDisc": totAfterDisc,
    "vat": vat,
    "totalAfterVat": totalAfterVat,
    "amountRecieved": amountRecieved,
    "changeGiven": changeGiven,
    "customerId": customerId,
    "deliveryStatus": deliveryStatus,
    "delieveryTime": delieveryTime.toIso8601String(),
    "deliveryPerson": deliveryPerson,
    "remarks": remarks,
    "isDelivered": isDelivered,
    "isConfirmed": isConfirmed,
    "isPaid": isPaid,
    "isDeleted": isDeleted,
  };
}
