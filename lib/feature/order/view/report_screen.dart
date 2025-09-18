import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ahwa_manager/feature/order/view/widget/custom_report_card.dart';
import 'package:smart_ahwa_manager/feature/order/view_model/order_cubit/order_cubit.dart';
import 'package:smart_ahwa_manager/core/utils/app_colors.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrderCubit>();
    final reports = cubit.getReports();

    final pendingCount = cubit.pendingOrders.length;
    final completedCount = cubit.completedOrders.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("📊 التقارير"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            CustomReportCard(
              title: "إجمالي الإيرادات",
              value: "${reports["totalRevenue"]?.toStringAsFixed(2)} ج.م",
              color: AppColors.success,
              icon: Icons.attach_money,
            ),
            CustomReportCard(
              title: "الطلبات المعلّقة",
              value: "$pendingCount طلب",
              color: AppColors.warning,
              icon: Icons.pending_actions,
            ),
            CustomReportCard(
              title: "الطلبات المكتملة",
              value: "$completedCount طلب",
              color: AppColors.accent,
              icon: Icons.check_circle,
            ),
            CustomReportCard(
              title: "أكثر مشروب مبيعًا",
              value: reports["topDrink"] != null
                  ? "${reports["topDrink"]} (${reports["topDrinkCount"]})"
                  : "لا يوجد بيانات",
              color: AppColors.primary,
              icon: Icons.local_cafe,
            ),
            CustomReportCard(
              title: "أكثر إضافة مطلوبة",
              value: reports["topAddition"] != null
                  ? "${reports["topAddition"]} (${reports["topAdditionCount"]})"
                  : "لا يوجد بيانات",
              color: AppColors.secondary,
              icon: Icons.add_circle,
            ),
          ],
        ),
      ),
    );
  }
}
