import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:quitanda/src/config/app_data.dart' as appData;
import 'package:quitanda/src/config/custom_colors.dart';
import 'package:quitanda/src/pages/orders/controller/all_orders_controller.dart';
import 'package:quitanda/src/pages/orders/view/components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.customSwatchColor,
        title: const Text(
          'Orders',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: GetBuilder<AllOrdersController>(
        builder: (controller) {
          return ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (_, index) {
                return OrderTile(order: controller.allOrders[index]);
              },
              itemCount: controller.allOrders.length);
        }
      ),
    );
  }
}
