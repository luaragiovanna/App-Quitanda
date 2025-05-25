import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import 'package:quitanda/src/config/custom_colors.dart';
import 'package:quitanda/src/models/order_model.dart';
import 'package:quitanda/src/services/utils_services.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel order;
  PaymentDialog({super.key, required this.order});
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //TITULO
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Pagamento com Pix',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                //QR CODE
                Image.memory(
                  utilsServices.decodeQrCodeImage(order.qrCodeImage),
                  height: 200,
                  width: 200,
                ),

                //VENCIMENTO
                Text(
                  'Vencimento: ${utilsServices.formatDateTime(order.overdueDateTime)}',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),

                //TOTAL
                Text(
                  'Total: ${utilsServices.priceToCurrency(order.total)}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),

                //COPIA E COLA
                OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        )),
                    onPressed: () {
                      //
                      FlutterClipboard.copy(order.copyAndPaste);
                      utilsServices.showToast(message: 'Código copiado');
                    },
                    icon: Icon(
                      Icons.copy,
                      size: 15,
                      color: newCustomColors.customSwatchColor,
                    ),
                    label: Text(
                      'Copiar código pix ',
                      style: TextStyle(
                        fontSize: 13,
                        color: newCustomColors.customSwatchColor,
                      ),
                    ))
              ],
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close)))
        ],
      ),
    );
  }
}
