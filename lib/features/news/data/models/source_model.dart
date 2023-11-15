import 'dart:convert';

SourceModel sourceFromJson(String str) => SourceModel.fromJson(json.decode(str));
String sourceToJson(SourceModel data) => json.encode(data.toJson());
class SourceModel {
  SourceModel({
      dynamic id, 
      String? name,}){
    _id = id;
    _name = name;
}

  SourceModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  dynamic _id;
  String? _name;
SourceModel copyWith({  dynamic id,
  String? name,
}) => SourceModel(  id: id ?? _id,
  name: name ?? _name,
);
  dynamic get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}