import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ahwa_manager/core/utils/app_colors.dart';
import 'package:smart_ahwa_manager/core/utils/app_styles.dart';
import 'package:smart_ahwa_manager/feature/order/view/widget/custom_order_list.dart';
import 'package:smart_ahwa_manager/feature/order/view_model/order_cubit/order_cubit.dart';

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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الطلبات",
          style: AppStyles.styleSemiBold20(
            context,
          ).copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.secondary,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
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

            return TabBarView(
              controller: _tabController,
              children: [
                CustomOrderList(orders: cubit.pendingOrders, isPending: true),
                CustomOrderList(
                  orders: cubit.completedOrders,
                  isPending: false,
                ),
              ],
            );
          }
          return const Center(child: Text("ابدأ بإضافة طلب"));
        },
      ),
    );
  }
}
