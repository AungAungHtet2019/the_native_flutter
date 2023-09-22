// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lat_lng_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLngModel _$LatLngModelFromJson(Map<String, dynamic> json) => LatLngModel(
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$LatLngModelToJson(LatLngModel instance) =>
    <String, dynamic>{
      'lng': instance.lng,
      'lat': instance.lat,
    };
