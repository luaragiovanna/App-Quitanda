import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda/src/config/custom_colors.dart';
import 'package:quitanda/src/models/cart_item_model.dart';
import 'package:quitanda/src/models/order_model.dart';
import 'package:quitanda/src/pages/orders/controller/order_controller.dart';
import 'package:quitanda/src/pages/orders/view/components/order_status_widget.dart';
import 'package:quitanda/src/pages/widgets/payment_dialog.dart';
import 'package:quitanda/src/services/utils_services.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;
  OrderTile({super.key, required this.order});
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
            dividerColor:
                Colors.transparent), //divisor some quando vai abrir o card
        child: GetBuilder<OrderController>(
            init: OrderController(order),
            global: false, //n vai ser refletido para os outros cards
            builder: (controller) {
              return ExpansionTile(
                onExpansionChanged: (value) {
                  //sempre q abre e fecha o detalhe da lista
                  if (value && order.items.isEmpty) {
                    controller.getOrderItems();
                  }
                },
                // initiallyExpanded: order.status == 'peding_payment',
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order: ${order.id}',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 31, 111, 34)),
                    ),
                    Text(
                      utilsServices.formatDateTime(order.createdDateTime!),
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    )
                  ],
                ),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                expandedCrossAxisAlignment: CrossAxisAlignment
                    .stretch, //espacamento interno do children
                children: controller.isLoading
                    ? [
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                        )
                      ]
                    : [
                        IntrinsicHeight(
                          //vao crescer o tamanho qual seja necessario ate o tamanho do widget de status
                          //verticaldivider vai ter ref de widget
                          child: Row(
                            children: [
                              //LISTA DE PRODUTO

                              Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 150,
                                    child: ListView(
                                        children: order.items.map((orderItem) {
                                      return _OrderItemWidget(
                                        utilsServices: utilsServices,
                                        orderItem: orderItem,
                                      );
                                    }).toList()),
                                  )),

                              //DIVISAO
                              VerticalDivider(
                                color: newCustomColors.customSwatchColor,
                                thickness: 2,
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: OrderStatusWidget(
                                  status: order.status,
                                  isOverdue: order.overdueDateTime
                                      .isBefore(DateTime.now()),
                                ),
                              )
                            ],
                          ),
                        ),
                        //TOTAL
                        Text.rich(
                          TextSpan(
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Total: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: utilsServices
                                      .priceToCurrency(order.total),
                                ),
                              ]),
                        ),
                        //BOTAO PAGAMENTO
                        Visibility(
                          visible: order.status == 'peding_payment' &&
                              !order.isOverDue,
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shadowColor:
                                    const Color.fromARGB(255, 109, 109, 109),
                                backgroundColor: newCustomColors.customSwatchColor,
                                iconColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return PaymentDialog(
                                      order: order,
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.pix),
                              label: const Text(
                                'QR Code Pix',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                        )
                      ],
              );
            }),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  final UtilsServices utilsServices;
  final CartItemModel orderItem;
  const _OrderItemWidget({
    super.key,
    required this.utilsServices,
    required this.orderItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            ' ${orderItem.quantity} ${orderItem.item.unit}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              orderItem.item.itemName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(utilsServices.priceToCurrency(orderItem.totalPrice()))
        ],
      ),
    );
  }
}
