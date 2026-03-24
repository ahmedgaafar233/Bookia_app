class OrderHistoryResponseModel {
  int? status;
  String? message;
  OrderData? data;

  OrderHistoryResponseModel({this.status, this.message, this.data});

  OrderHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? OrderData.fromJson(json['data']) : null;
  }
}

class OrderData {
  List<OrderItem>? orders;

  OrderData({this.orders});

  OrderData.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <OrderItem>[];
      json['orders'].forEach((v) {
        orders!.add(OrderItem.fromJson(v));
      });
    }
  }
}

class OrderItem {
  int? id;
  String? orderNumber;
  String? total;
  String? date;
  String? status;

  OrderItem({this.id, this.orderNumber, this.total, this.date, this.status});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
  }
}
