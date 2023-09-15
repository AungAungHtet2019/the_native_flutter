class AutoGenerate {
  AutoGenerate({
    required this.sceneId,
    required this.viewId,
    required this.date,
    required this.cloud,
    required this.notes,
    required this.indexes,
  });
  late final String sceneId;
  late final String viewId;
  late final String date;
  late final int cloud;
  late final List<dynamic> notes;
  late final Indexes indexes;

  AutoGenerate.fromJson(Map<String, dynamic> json){
    sceneId = json['scene_id'];
    viewId = json['view_id'];
    date = json['date'];
    cloud = json['cloud'];
    notes = List.castFrom<dynamic, dynamic>(json['notes']);
    indexes = Indexes.fromJson(json['indexes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['scene_id'] = sceneId;
    _data['view_id'] = viewId;
    _data['date'] = date;
    _data['cloud'] = cloud;
    _data['notes'] = notes;
    _data['indexes'] = indexes.toJson();
    return _data;
  }
}

class Indexes {
  Indexes({
    required this.NDVI,
    required this.MSI,
    required this.EVI,
  });
  late final NDVI NDVI;
  late final MSI MSI;
  late final EVI EVI;

  Indexes.fromJson(Map<String, dynamic> json){
    NDVI = NDVI.fromJson(json['NDVI']);
    MSI = MSI.fromJson(json['MSI']);
    EVI = EVI.fromJson(json['EVI']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['NDVI'] = NDVI.toJson();
    _data['MSI'] = MSI.toJson();
    _data['EVI'] = EVI.toJson();
    return _data;
  }
}

class NDVI {
  NDVI({
    required this.min,
    required this.max,
    required this.average,
    required this.std,
    required this.variance,
    required this.q1,
    required this.q3,
    required this.median,
    required this.p10,
    required this.p90,
  });
  late final double min;
  late final double max;
  late final double average;
  late final double std;
  late final double variance;
  late final double q1;
  late final double q3;
  late final double median;
  late final double p10;
  late final double p90;

  NDVI.fromJson(Map<String, dynamic> json){
    min = json['min'];
    max = json['max'];
    average = json['average'];
    std = json['std'];
    variance = json['variance'];
    q1 = json['q1'];
    q3 = json['q3'];
    median = json['median'];
    p10 = json['p10'];
    p90 = json['p90'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['min'] = min;
    _data['max'] = max;
    _data['average'] = average;
    _data['std'] = std;
    _data['variance'] = variance;
    _data['q1'] = q1;
    _data['q3'] = q3;
    _data['median'] = median;
    _data['p10'] = p10;
    _data['p90'] = p90;
    return _data;
  }
}

class MSI {
  MSI({
    required this.min,
    required this.max,
    required this.average,
    required this.std,
    required this.variance,
    required this.q1,
    required this.q3,
    required this.median,
    required this.p10,
    required this.p90,
  });
  late final double min;
  late final double max;
  late final double average;
  late final double std;
  late final double variance;
  late final double q1;
  late final double q3;
  late final double median;
  late final double p10;
  late final double p90;

  MSI.fromJson(Map<String, dynamic> json){
    min = json['min'];
    max = json['max'];
    average = json['average'];
    std = json['std'];
    variance = json['variance'];
    q1 = json['q1'];
    q3 = json['q3'];
    median = json['median'];
    p10 = json['p10'];
    p90 = json['p90'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['min'] = min;
    _data['max'] = max;
    _data['average'] = average;
    _data['std'] = std;
    _data['variance'] = variance;
    _data['q1'] = q1;
    _data['q3'] = q3;
    _data['median'] = median;
    _data['p10'] = p10;
    _data['p90'] = p90;
    return _data;
  }
}

class EVI {
  EVI({
    required this.min,
    required this.max,
    required this.average,
    required this.std,
    required this.variance,
    required this.q1,
    required this.q3,
    required this.median,
    required this.p10,
    required this.p90,
  });
  late final double min;
  late final double max;
  late final double average;
  late final double std;
  late final double variance;
  late final double q1;
  late final double q3;
  late final double median;
  late final double p10;
  late final double p90;

  EVI.fromJson(Map<String, dynamic> json){
    min = json['min'];
    max = json['max'];
    average = json['average'];
    std = json['std'];
    variance = json['variance'];
    q1 = json['q1'];
    q3 = json['q3'];
    median = json['median'];
    p10 = json['p10'];
    p90 = json['p90'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['min'] = min;
    _data['max'] = max;
    _data['average'] = average;
    _data['std'] = std;
    _data['variance'] = variance;
    _data['q1'] = q1;
    _data['q3'] = q3;
    _data['median'] = median;
    _data['p10'] = p10;
    _data['p90'] = p90;
    return _data;
  }
}