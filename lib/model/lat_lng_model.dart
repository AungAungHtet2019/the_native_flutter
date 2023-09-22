import 'package:json_annotation/json_annotation.dart';


part 'lat_lng_model.g.dart';

@JsonSerializable(explicitToJson: true)

class LatLngModel {
  LatLngModel({
    required this.lng,
    required this.lat,
  });
  @JsonKey(name: 'lng', defaultValue: 0.00)
  double lng;

  @JsonKey(name: 'lat', defaultValue: 0.00)
  double lat;

  factory LatLngModel.fromJson(Map<String,dynamic> data) => _$LatLngModelFromJson(data);

  Map<String,dynamic> toJson() => _$LatLngModelToJson(this);
}