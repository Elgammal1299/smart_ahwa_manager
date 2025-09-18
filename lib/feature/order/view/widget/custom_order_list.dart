import 'package:flutter/material.dart';
import 'package:smart_ahwa_manager/core/utils/app_colors.dart';
import 'package:smart_ahwa_manager/feature/order/view/widget/custom_order_item_card.dart';

class CustomOrderList extends StatelessWidget {
  final List orders;
  final bool isPending;

  const CustomOrderList({
    super.key,
    required this.orders,
    required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          isPending ? "لا توجد طلبات معلّقة" : "لا توجد طلبات مكتملة",
          style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),
        ),
      );
    }
    return ListView.builder(
      itemCount: orders.length,
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderItemCard(
          order: order,
          index: index,
          isPending: isPending,
        );
      },
    );
  }
}
