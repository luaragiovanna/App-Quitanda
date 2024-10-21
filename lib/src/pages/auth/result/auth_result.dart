import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quitanda/src/models/user_model.dart';

part 'auth_result.freezed.dart';

@freezed
class AuthResult with _$AuthResult {
  //possiveis resultados q ela contem
  factory AuthResult.success(UserModel user) = Success;

  //retornar erro
  factory AuthResult.error(String message) = Error;
  
}
