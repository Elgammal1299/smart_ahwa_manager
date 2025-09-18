import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ahwa_manager/feature/home/view_model/order_cubit/order_cubit.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<OrderCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الطلبات"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "المعلّقة"),
            Tab(text: "المكتملة"),
          ],
        ),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is OrderSuccess) {
            final cubit = context.read<OrderCubit>();

            final pending = cubit.pendingOrders;
            final completed = cubit.completedOrders;

            return TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList(context, pending, isPending: true),
                _buildOrderList(context, completed, isPending: false),
              ],
            );
          }
          return const Center(child: Text("ابدأ بإضافة طلب"));
        },
      ),
    );
  }

  Widget _buildOrderList(
    BuildContext context,
    List orders, {
    required bool isPending,
  }) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          isPending ? "لا توجد طلبات معلّقة" : "لا توجد طلبات مكتملة",
        ),
      );
    }
    return ListView.builder(
      itemCount: orders.length,
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.brown.shade100,
                  child: Icon(
                    Icons.local_cafe,
                    color: Colors.brown.shade700,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.customerName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${order.drink} - ${order.addition ?? "بدون إضافات"}",
                      ),
                      Text("الكمية: ${order.quantity}"),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${order.price} ج.م",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    if (isPending)
                      IconButton(
                        icon: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          context.read<OrderCubit>().completeOrder(index);
                        },
                      ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<OrderCubit>().removeOrder(index);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
