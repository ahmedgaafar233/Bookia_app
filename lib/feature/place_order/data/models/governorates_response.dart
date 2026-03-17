import 'governorate_data.dart';

class GovernoratesResponse {
  List<GovernorateData>? data;

  GovernoratesResponse({this.data});

  GovernoratesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GovernorateData>[];
      json['data'].forEach((v) {
        data!.add(GovernorateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
