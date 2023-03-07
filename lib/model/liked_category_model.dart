class LikedCategoryModel {
  LikedCategoryModel({
    required this.Id,
    required this.UserID,
    required this.CategoryID,
  });
  late final String Id;
  late final String UserID;
  late final String CategoryID;

  LikedCategoryModel.fromJson(Map<String, dynamic> json){
    Id = json['id'].toString();
    UserID = json['userID'].toString();
    CategoryID = json['category_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = Id;
    _data['userID'] = UserID;
    _data['category_id'] = CategoryID;
    return _data;
  }
}