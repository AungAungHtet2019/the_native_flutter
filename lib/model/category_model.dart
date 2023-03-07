class CategoryModel {
  CategoryModel({
    required this.AutoID,
    required this.CategoryCode,
    required this.CategoryName,
    required this.Active,
    required this.CreatedBy,
    required this.CreatedDate,
  });
  late final String AutoID;
  late final String CategoryCode;
  late final String CategoryName;
  late final String Active;
  late final String CreatedBy;
  late final String CreatedDate;

  CategoryModel.fromJson(Map<String, dynamic> json){
    AutoID = json['Auto_ID'].toString();
    CategoryCode = json['Category_Code'].toString();
    CategoryName = json['Category_Name'].toString();
    Active = json['Active'].toString();
    CreatedBy = json['Created_By'].toString();
    CreatedDate = json['Created_Date'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Auto_ID'] = AutoID;
    _data['Category_Code'] = CategoryCode;
    _data['Category_Name'] = CategoryName;
    _data['Active'] = Active;
    _data['Created_By'] = CreatedBy;
    _data['Created_Date'] = CreatedDate;
    return _data;
  }
}