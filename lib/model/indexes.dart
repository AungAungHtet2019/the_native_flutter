import 'package:json_annotation/json_annotation.dart';

import 'evi.dart';
import 'msi.dart';
import 'ndre.dart';
import 'ndsi.dart';
import 'ndvi.dart';
import 'savi.dart';

part 'indexes.g.dart';

@JsonSerializable(explicitToJson: true)

class Indexes {
  Indexes({
    required this.ndvi,
    required this.msi,
    required this.evi,
    required this.ndsi,
    required this.savi,
    required this.ndre,
  });

  @JsonKey(name: 'NDVI', defaultValue: null)
  NDVI? ndvi;

  @JsonKey(name: 'MSI', defaultValue: null)
  MSI? msi;

  @JsonKey(name: 'EVI', defaultValue: null)
  EVI? evi;

  @JsonKey(name:'NDSI', defaultValue:  null)
  NDSI? ndsi;

  @JsonKey(name: 'SAVI', defaultValue:  null)
  SAVI? savi;

  @JsonKey(name: '(B08-B05)/(B08+B05)', defaultValue: null)
  NDRE? ndre;



  factory Indexes.fromJson(Map<String,dynamic> data) => _$IndexesFromJson(data);

  Map<String,dynamic> toJson() => _$IndexesToJson(this);
}