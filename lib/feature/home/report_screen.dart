import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ahwa_manager/feature/home/view_model/order_cubit/order_cubit.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrderCubit>();
    final reports = cubit.getReports();

    final pendingCount = cubit.pendingOrders.length;
    final completedCount = cubit.completedOrders.length;

    return Scaffold(
      appBar: AppBar(title: const Text("التقارير")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildReportCard(
              title: "إجمالي الإيرادات",
              value: "${reports["totalRevenue"]?.toStringAsFixed(2)} ج.م",
              color: Colors.green,
              icon: Icons.attach_money,
            ),
            _buildReportCard(
              title: "الطلبات المعلّقة",
              value: "$pendingCount طلب",
              color: Colors.orange,
              icon: Icons.pending_actions,
            ),
            _buildReportCard(
              title: "الطلبات المكتملة",
              value: "$completedCount طلب",
              color: Colors.blue,
              icon: Icons.check_circle,
            ),
            _buildReportCard(
              title: "أكثر مشروب مبيعًا",
              value: reports["topDrink"] != null
                  ? "${reports["topDrink"]} (${reports["topDrinkCount"]})"
                  : "لا يوجد بيانات",
              color: Colors.brown,
              icon: Icons.local_cafe,
            ),
            _buildReportCard(
              title: "أكثر إضافة مطلوبة",
              value: reports["topAddition"] != null
                  ? "${reports["topAddition"]} (${reports["topAdditionCount"]})"
                  : "لا يوجد بيانات",
              color: Colors.purple,
              icon: Icons.add_circle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          value,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
        ),
      ),
    );
  }
}
