import 'package:freezed_annotation/freezed_annotation.dart';
part 'cart_result.freezed.dart';

@freezed
class CartResult<T> with _$CartResult {
  factory CartResult.success(T data) = Succes; //data e o tipo q ta fornecendo
  factory CartResult.error(String message) = Error;
  
}
