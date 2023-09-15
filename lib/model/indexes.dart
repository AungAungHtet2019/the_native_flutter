import 'package:json_annotation/json_annotation.dart';

import '../components/evi.dart';
import 'msi.dart';
import 'ndvi.dart';

part 'indexes.g.dart';

@JsonSerializable(explicitToJson: true)

class Indexes {
  Indexes({
    required this.ndvi,
    required this.msi,
    required this.evi,
  });

  @JsonKey(name: 'NDVI', defaultValue: null)
  NDVI? ndvi;

  @JsonKey(name: 'MSI', defaultValue: null)
  MSI? msi;

  @JsonKey(name: 'EVI', defaultValue: null)
  EVI? evi;


  factory Indexes.fromJson(Map<String,dynamic> data) => _$IndexesFromJson(data);

  Map<String,dynamic> toJson() => _$IndexesToJson(this);
}