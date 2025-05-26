import 'package:flutter/material.dart';

import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return "Digite um email";
  }
  if (!email.isEmail) return 'Formato de aishduahsdushduhd invalido';
  if (email.length < 5) {
    return "Digite pelo menos 5 caracteres.";
  }
  if (email.length > 50) {
    return "Digite no maximo 50 caracteres.";
  }
  if (!email.contains('@')) {
    return "Digite um email valido";
  }
  return null;
  var emailLower = email.toLowerCase();
  if (!GetUtils.isEmail(emailLower)) {
    return 'Invalid email format';
  }
}

String? passwordValidator(password) {
  if (password == null || password.isEmpty) {
    return "Insert your password";
  }
  if (password.length < 7) {
    return "Digite pelo menos 7 caracteres.";
  }
  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Digite um nome';
  }
  final names = name.split(' ');

  if (names.length == 1) {
    return 'Digite seu nome completo';
  }
  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Digite um numero';
  }
  if (phone.length < 14 || !phone.isPhoneNumber) {
    return 'Digite um numero valido';
  }
  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Digite um cpf';
  }
  if (!cpf.isCpf) {
    return 'Digite um CPF valido';
  }
  return null;
}
