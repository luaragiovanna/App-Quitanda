// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quitanda/src/models/item_model.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  @JsonKey(name: 'product')
  ItemModel item;
  String id;
  int quantity;
//metodo pra retornar valor total do carrinho
  CartItemModel({required this.id, required this.item, required this.quantity});

  totalPrice() {
    return item.price * quantity;
  }

  //estruturar com base no postman
  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);
      
  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);

  @override
  String toString() => 'CartItemModel(item: $item, id: $id, quantity: $quantity)';
}
