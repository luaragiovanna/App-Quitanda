// ignore: depend_on_referenced_packages
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilsServices {
  final storage = FlutterSecureStorage();

  //SALVAR DADO LOCALMENTE
  Future<void> saveLocalData(
      {required String key, required String data}) async {
    //chave atrelada a um valor
    await storage.write(key: key, value: data);
  }

  //RECUPERAR DADO SALVO LOCALMENTE
  Future<String?> getLocalData({required String key}) async {
    //salva o dado localmente (em formato de string) e recupera em formato de string. e dado pode n ser encontrado
    await storage.read(key: key);
  }

  //REMOVE DADO SALVO LOCALMENTE
  Future<void> removeLocalData({required String key}) async {
    await storage.delete(key: key);
  }

  //retorna valor string contendo R$
  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'en_US');

    //retorna a string formatada
    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();
    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime.toLocal());
  }

  void showToast({required String message, bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, //onde msg vai ser apresentada na tela
      timeInSecForIosWeb: 3,
      backgroundColor:
          isError ? const Color.fromARGB(255, 7, 1, 0) : Colors.white,
      textColor: isError ? Colors.white : Colors.black,
      fontSize: 14,
    );
  }

  Uint8List decodeQrCodeImage(String value) {
    //recuperar o trecho pertinente a imagem
    String base64String = value
        .split(',')
        .last; //vai pegar o trecho apos a virgula (q eh referente a iamgem do qrcode)
    return base64.decode(base64String);
  }
}
