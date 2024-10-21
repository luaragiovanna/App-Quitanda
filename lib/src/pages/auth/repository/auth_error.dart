//quando passar codigo do erro ex: invalid credentials passa pro usuario uma mensagem mais descritiva

import 'package:flutter/material.dart';

String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha invalidos';
    case 'Invalid session token':
      return 'Token invalido';

    case 'INVALID_FULLNAME':
      return 'Ocorreu um erro ao cadastrar usuario: nome infalido';

    case 'INVALID_PHONE':
      return 'Ocorreu um erro ao cadastrar telefone.';
    case 'INVALID_CPF':
      return 'Ocorreu um erro ao cadastrar CPF. Verifique no invoicy';
    default:
      return 'Um erro indefinido ocorreu';
  }
}
