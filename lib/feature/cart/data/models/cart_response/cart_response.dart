import 'data.dart';

class CartResponseModel {
  int? status;
  String? message;
  Data? data;

  CartResponseModel({this.status, this.message, this.data});

  CartResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null && json['data'] is Map<String, dynamic>) {
      data = Data.fromJson(json['data']);
    } else {
      data = null;
    }
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
