class LoginResponseModel {
  final int? status;
  final String? message;
  final LoginData? data;

  LoginResponseModel({this.status, this.message, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }
}

class LoginData {
  final User? user;
  final String? token;

  LoginData({this.user, this.token});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'],
    );
  }
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? image;

  User({this.id, this.name, this.email, this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
    );
  }
}
