class GovernorateData {
  int? id;
  String? governorateNameEn;

  GovernorateData({this.id, this.governorateNameEn});

  GovernorateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    governorateNameEn = json['governorate_name_en'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'governorate_name_en': governorateNameEn,
      };
}
