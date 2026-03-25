class SliderResponseModel {
  int? status;
  String? message;
  SliderData? data;

  SliderResponseModel({this.status, this.message, this.data});

  SliderResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null && json['data'] is Map<String, dynamic>) {
      data = SliderData.fromJson(json['data']);
    } else {
      data = null;
    }
  }
}

class SliderData {
  List<Sliders>? sliders;

  SliderData({this.sliders});

  SliderData.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(Sliders.fromJson(v));
      });
    }
  }
}

class Sliders {
  int? id;
  String? image;

  Sliders({this.id, this.image});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
