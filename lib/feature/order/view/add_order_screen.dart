import 'package:flutter/material.dart';
import 'package:smart_ahwa_manager/core/utils/app_colors.dart';
import 'package:smart_ahwa_manager/core/utils/app_styles.dart';
import 'package:smart_ahwa_manager/feature/order/view/widget/add_order_form.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Smart Ahwa Manager',
            style: AppStyles.styleSemiBold20(
              context,
            ).copyWith(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [SizedBox(height: 20), CustomAddOrderTextField()],
          ),
        ),
      ),
    );
  }
}
