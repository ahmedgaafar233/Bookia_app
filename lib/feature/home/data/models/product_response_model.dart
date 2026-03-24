class ProductResponseModel {
  int? status;
  String? message;
  ProductData? data;

  ProductResponseModel({this.status, this.message, this.data});

  ProductResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ProductData.fromJson(json['data']) : null;
  }
}

class ProductData {
  List<Product>? products;

  ProductData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    } else if (json['data'] != null && json['data'] is List) {
      products = <Product>[];
      json['data'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }
}

class Product {
  int? id;
  String? name;
  String? description;
  String? price;
  String? discount;
  String? priceAfterDiscount;
  String? image;
  int? categoryId;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.image,
    this.categoryId,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    discount = json['discount'].toString();
    priceAfterDiscount = json['price_after_discount'].toString();
    image = json['image'];
    categoryId = json['category_id'];
  }
}
