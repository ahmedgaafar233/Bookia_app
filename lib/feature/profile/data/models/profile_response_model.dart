class ProfileResponseModel {
  int? status;
  String? message;
  User? data;

  ProfileResponseModel({this.status, this.message, this.data});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null && json['data'] is Map<String, dynamic>) {
      data = User.fromJson(json['data']);
    } else {
      data = null;
    }
  }
}

// ProfileData removed as it's redundant

class User {
  int? id;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? image;

  User({this.id, this.name, this.email, this.address, this.phone, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    image = json['image'];
  }
}
