class DeliveryBoyModel {
  String? id;
  String? name;
  String? contact;
  double? latitude;
  double? longitude;

  DeliveryBoyModel(
      {required this.id,
      required this.name,
      required this.contact,
      required this.latitude,
      required this.longitude});

  double? get currentLatitude => latitude;
  double? get currentLongitude => longitude;

  factory DeliveryBoyModel.fromJson(Map<String, dynamic> json) {
    return DeliveryBoyModel(
        id: json['id'],
        name: json['name'],
        contact: json['contact'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }
}
