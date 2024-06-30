class Routes {
  final int routeId;
  final String name;
  final String description;

  Routes({
    required this.routeId,
    required this.name,
    required this.description,
  });

  // Factory method to create an instance from JSON
  factory Routes.fromJson(Map<String, dynamic> json) {
    return Routes(
      routeId: json['routeId'],
      name: json['name'],
      description: json['description'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'routeId': routeId,
      'name': name,
      'description': description,
    };
  }
}

class ApiResponse {
  final bool isValid;
  final String message;
  final List<Routes> data;

  ApiResponse({
    required this.isValid,
    required this.message,
    required this.data,
  });

  // Factory method to create an instance from JSON
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Routes> routesList = list.map((i) => Routes.fromJson(i)).toList();

    return ApiResponse(
      isValid: json['isValid'],
      message: json['message'],
      data: routesList,
    );
  }
}