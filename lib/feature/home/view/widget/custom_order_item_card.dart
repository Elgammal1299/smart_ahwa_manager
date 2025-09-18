import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ahwa_manager/core/utils/app_colors.dart';
import 'package:smart_ahwa_manager/core/utils/app_styles.dart';
import 'package:smart_ahwa_manager/feature/home/view_model/order_cubit/order_cubit.dart';

class OrderItemCard extends StatelessWidget {
  final dynamic order; // ممكن تعرّف موديل مخصص للـ Order هنا
  final int index;
  final bool isPending;

  const OrderItemCard({
    super.key,
    required this.order,
    required this.index,
    required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPending ? AppColors.warning : AppColors.success,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.secondary.withOpacity(0.2),
              child: Icon(Icons.local_cafe, color: AppColors.primary, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الاسم + الكمية + السعر
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          order.customerName,
                          style: AppStyles.styleSemiBold20(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "x${order.quantity}",
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "${order.price} ج.م",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // المشروب + الإضافة
                  Text(
                    "${order.drink} - ${order.addition ?? "بدون إضافات"}",
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 12),
                  // الأزرار (يمين/شمال)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: AppColors.error),
                        onPressed: () {
                          context.read<OrderCubit>().removeOrder(index);
                        },
                      ),
                      if (isPending)
                        IconButton(
                          icon: const Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                          ),
                          onPressed: () {
                            context.read<OrderCubit>().completeOrder(index);
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
