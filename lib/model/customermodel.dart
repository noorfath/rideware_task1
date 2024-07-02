class Customermodel {
  bool isValid;
  String message;
  List<Datum> data;

  Customermodel({
    required this.isValid,
    required this.message,
    required this.data,
  });

  // Factory method to create an instance from JSON
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

  // Factory method to create an instance from JSON
  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      custId: json['custId'],
      name: json['name'],
      routeId: json['routeId'],
    );
  }
}
