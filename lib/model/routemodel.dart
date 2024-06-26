class RouteModel {
  final String routeName;

  RouteModel({required this.routeName});

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      routeName: json['routeName'],
    );
  }
}
