import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ahwa_manager/feature/home/view_model/order_cubit/order_cubit.dart';
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
            _buildReportContainer(
              title: "إجمالي الإيرادات",
              value: "${reports["totalRevenue"]?.toStringAsFixed(2)} ج.م",
              color: AppColors.success,
              icon: Icons.attach_money,
            ),
            _buildReportContainer(
              title: "الطلبات المعلّقة",
              value: "$pendingCount طلب",
              color: AppColors.warning,
              icon: Icons.pending_actions,
            ),
            _buildReportContainer(
              title: "الطلبات المكتملة",
              value: "$completedCount طلب",
              color: AppColors.accent,
              icon: Icons.check_circle,
            ),
            _buildReportContainer(
              title: "أكثر مشروب مبيعًا",
              value: reports["topDrink"] != null
                  ? "${reports["topDrink"]} (${reports["topDrinkCount"]})"
                  : "لا يوجد بيانات",
              color: AppColors.primary,
              icon: Icons.local_cafe,
            ),
            _buildReportContainer(
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

  Widget _buildReportContainer({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.7), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
