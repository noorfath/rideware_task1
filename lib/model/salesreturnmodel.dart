class Customermodel {
  final int soId;
  final String customerName;
  final double totalafterVat;
  final List<Detail> detail;

  Customermodel({
    required this.soId,
    required this.customerName,
    required this.totalafterVat,
    required this.detail,
  });

  factory Customermodel.fromJson(Map<String, dynamic> json) {
    var list = json['detail'] as List;
    List<Detail> detailList = list.map((i) => Detail.fromJson(i)).toList();

    return Customermodel(
      soId: (json['soId'] as num).toInt(),
      customerName: json['customerName'],
      totalafterVat: (json['totalafterVat'] as num).toDouble(),
      detail: detailList,
    );
  }
}

class Detail {
  final String itemName;
  final int quantity;
  final double price;
  final double total;

  Detail({
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.total,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      itemName: json['itemName'],
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }
}