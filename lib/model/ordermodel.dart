class Order {
  int soId;
  int createdBy;
  int customerId;
  List<OrderItem> items;
  double total;
  double discount;
  double totalAfterDiscount;
  bool isVat;
  bool isVatExclusive;
  bool isVatInclusive;
  String remarks;

  Order({
    required this.soId,
    required this.createdBy,
    required this.customerId,
    required this.items,
    required this.total,
    required this.discount,
    required this.totalAfterDiscount,
    required this.isVat,
    required this.isVatExclusive,
    required this.isVatInclusive,
    required this.remarks,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    // Parse JSON and return Order object
    return Order(
      soId: json['soId'],
      createdBy: json['createdBy'],
      customerId: json['customerId'],
      items: (json['items'] as List)
          .map((itemJson) => OrderItem.fromJson(itemJson))
          .toList(),
      total: json['total'],
      discount: json['discount'],
      totalAfterDiscount: json['totalAfterDiscount'],
      isVat: json['isVat'],
      isVatExclusive: json['isVatExclusive'],
      isVatInclusive: json['isVatInclusive'],
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    // Convert Order object to JSON
    return {
      'soId': soId,
      'createdBy': createdBy,
      'customerId': customerId,
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'discount': discount,
      'totalAfterDiscount': totalAfterDiscount,
      'isVat': isVat,
      'isVatExclusive': isVatExclusive,
      'isVatInclusive': isVatInclusive,
      'remarks': remarks,
    };
  }
}

class OrderItem {
  int solId;
  int itemId;
  int categoryId;
  int quantity;
  double price;
  double total;
  String remarks;

  OrderItem({
    required this.solId,
    required this.itemId,
    required this.categoryId,
    required this.quantity,
    required this.price,
    required this.total,
    required this.remarks,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    // Parse JSON and return OrderItem object
    return OrderItem(
      solId: json['solId'],
      itemId: json['itemId'],
      categoryId: json['categoryId'],
      quantity: json['quantity'],
      price: json['price'],
      total: json['total'],
      remarks: json['remarks'],
    );
  }

  Map<String, dynamic> toJson() {
    // Convert OrderItem object to JSON
    return {
      'solId': solId,
      'itemId': itemId,
      'categoryId': categoryId,
      'quantity': quantity,
      'price': price,
      'total': total,
      'remarks': remarks,
    };
  }
}
