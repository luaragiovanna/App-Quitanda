// ignore_for_file: public_member_api_docs, sort_constructors_first
//classe precisa conhhecer o json pra fazr a serializacao
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quitanda/src/models/item_model.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  String title;
  String id;
  @JsonKey(defaultValue: [])
  List<ItemModel> items;

  @JsonKey(defaultValue: 0)
  int pagination;

  CategoryModel({required this.title, required this.id, required this.items, required this.pagination});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  //transforma pra um MAP
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  String toString() {
    return 'CategoryModel(title: $title, id: $id, items: $items, pagination: $pagination)';
  }
}
