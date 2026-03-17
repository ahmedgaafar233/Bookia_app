import 'data.dart';

class CartResponseModel {
  int? status;
  String? message;
  Data? data;

  CartResponseModel({this.status, this.message, this.data});

  CartResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
