import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_result.freezed.dart';

@freezed
class HomeResult<T> with _$HomeResult<T> { //sempre q o hoeresul é chamado, passa um tipo especifico
  factory HomeResult.success(List<T> data) = Success;
  factory HomeResult.error(String message) = Error;
  //dados em formato de lista(producto e categoria)
}
