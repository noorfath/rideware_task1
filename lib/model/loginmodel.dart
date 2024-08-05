class LoginApiResponse {
  final bool isValid;
  final String message;
  final Data data;

  LoginApiResponse({
    required this.isValid,
    required this.message,
    required this.data,
  });

  factory LoginApiResponse.fromJson(Map<String, dynamic> json) {
    return LoginApiResponse(
      isValid: json['isValid'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isValid': isValid,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Data {
  final User user;
  final String token;
  final String refreshToken;
  final String timezone;
  final String country;
  final String region;
  final String ipAddress;
  final String location;

  Data({
    required this.user,
    required this.token,
    required this.refreshToken,
    required this.timezone,
    required this.country,
    required this.region,
    required this.ipAddress,
    required this.location, required List<dynamic> detail,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: User.fromJson(json['user']),
      token: json['token'],
      refreshToken: json['refreshToken'],
      timezone: json['timezone'],
      country: json['country'],
      region: json['region'],
      ipAddress: json['ipAddress'],
      location: json['location'], detail: [], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'token': token,
      'refreshToken': refreshToken,
      'timezone': timezone,
      'country': country,
      'region': region,
      'ipAddress': ipAddress,
      'location': location,
    };
  }
}

class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String contactNo;
  final int roleId;
  final String roleText;
  final int companyId;
  final String companyName;
  final dynamic role;
  final String remarks;
  final bool isSuperUser;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final int createdBy;
  final int modifiedBy;
  final DateTime modifiedAt;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.contactNo,
    required this.roleId,
    required this.roleText,
    required this.companyId,
    required this.companyName,
    required this.role,
    required this.remarks,
    required this.isSuperUser,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.createdBy,
    required this.modifiedBy,
    required this.modifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      contactNo: json['contactNo'],
      roleId: json['roleId'],
      roleText: json['roleText'],
      companyId: json['companyId'],
      companyName: json['companyName'],
      role: json['role'],
      remarks: json['remarks'],
      isSuperUser: json['isSuperUser'],
      isActive: json['isActive'],
      isDeleted: json['isDeleted'],
      createdAt: DateTime.parse(json['createdAt']),
      createdBy: json['createdBy'],
      modifiedBy: json['modifiedBy'],
      modifiedAt: DateTime.parse(json['modifiedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'contactNo': contactNo,
      'roleId': roleId,
      'roleText': roleText,
      'companyId': companyId,
      'companyName': companyName,
      'role': role,
      'remarks': remarks,
      'isSuperUser': isSuperUser,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'modifiedAt': modifiedAt.toIso8601String(),
    };
  }
}
