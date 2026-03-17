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

  ProductData({this.products});

  ProductData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
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
  String? image;
  int? categoryId;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.discount,
    this.image,
    this.categoryId,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
    categoryId = json['category_id'];
  }
}
