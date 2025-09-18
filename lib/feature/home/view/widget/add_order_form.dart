import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ahwa_manager/core/utils/app_styles.dart';
import 'package:smart_ahwa_manager/core/widget/custom_elevated_button.dart';
import 'package:smart_ahwa_manager/core/widget/custom_text_form.dart';
import 'package:smart_ahwa_manager/feature/home/data/model/beverage_decorator%20.dart';
import 'package:smart_ahwa_manager/feature/home/data/model/component_model.dart';
import 'package:smart_ahwa_manager/feature/home/data/model/order_model.dart';
import 'package:smart_ahwa_manager/feature/home/view_model/order_cubit/order_cubit.dart';

class CustomAddOrderTextField extends StatefulWidget {
  const CustomAddOrderTextField({super.key});

  @override
  State<CustomAddOrderTextField> createState() =>
      _CustomAddOrderTextFeildState();
}

class _CustomAddOrderTextFeildState extends State<CustomAddOrderTextField> {
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  // المشروبات المتاحة
  final List<String> drinks = ["شاي", "قهوة", "عصير", "نسكافيه"];
  String? selectedDrink;

  // إضافات لكل مشروب
  final Map<String, List<String>> additionsMap = {
    "شاي": ["نعناع", "سكر زيادة", "سكر قليل", "لبن"],
    "قهوة": ["لبن", "بدون سكر", "سكر زيادة", "بندق"],
    "عصير": ["ثلج", "بدون سكر"],
    "نسكافيه": ["لبن", "سكر قليل", "سكر زيادة"],
  };
  final Map<String, Beverage Function()> beveragesFactory = {
    "شاي": () => Tea(),
    "قهوة": () => Coffee(),
    "عصير": () => Juice(),
    "نسكافيه": () => Nescafe(),
  };

  final Map<String, Beverage Function(Beverage)> additionsFactory = {
    "لبن": (b) => Milk(b),
    "نعناع": (b) => Mint(b),
    "سكر زيادة": (b) => Sugar(b),
  };

  String? selectedAddition;

  @override
  void dispose() {
    customerNameController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // الإضافات الخاصة بالمشروب الحالي
    final List<String> availableAdditions = selectedDrink != null
        ? additionsMap[selectedDrink]!
        : [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// اسم العميل
        Text('Customer name', style: AppStyles.styleBold16(context)),
        const SizedBox(height: 6),
        CustomTextForm(
          hintText: 'Customer name',
          controller: customerNameController,
        ),
        const SizedBox(height: 20),

        Text('The drink', style: AppStyles.styleBold16(context)),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: selectedDrink,
          items: drinks
              .map(
                (drink) => DropdownMenuItem(value: drink, child: Text(drink)),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedDrink = value;
              selectedAddition = null;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Choose a drink",
          ),
        ),
        const SizedBox(height: 20),

        /// العدد
        Text('Quantity', style: AppStyles.styleBold16(context)),
        const SizedBox(height: 6),
        CustomTextForm(
          hintText: 'Enter quantity',
          controller: quantityController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),

        if (selectedDrink != null) ...[
          Text('Additions', style: AppStyles.styleBold16(context)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: selectedAddition,
            items: availableAdditions
                .map(
                  (addition) =>
                      DropdownMenuItem(value: addition, child: Text(addition)),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedAddition = value;
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Choose an addition",
            ),
          ),
          const SizedBox(height: 20),
        ],

        CustomElevatedButton(
          onPressed: () {
            if (customerNameController.text.isEmpty ||
                selectedDrink == null ||
                quantityController.text.isEmpty) {
              return;
            }

            // إنشاء المشروب من الـ Map
            Beverage beverage = beveragesFactory[selectedDrink!]!();

            // تطبيق الإضافة (لو فيه)
            if (selectedAddition != null &&
                additionsFactory.containsKey(selectedAddition)) {
              final decorator = additionsFactory[selectedAddition];
              if (decorator != null) {
                beverage = decorator(beverage);
              }
            }

            // حساب السعر
            final double totalPrice =
                beverage.cost() * int.parse(quantityController.text);

            // حفظ الطلب
            context.read<OrderCubit>().addOrder(
              OrderModel(
                customerName: customerNameController.text,
                drink: beverage.description, // لاحظ: مع الإضافة
                addition: selectedAddition,
                quantity: int.parse(quantityController.text),
                price: totalPrice,
              ),
            );

            // Reset
            setState(() {
              customerNameController.clear();
              quantityController.clear();
              selectedDrink = null;
              selectedAddition = null;
            });
          },

          text: 'Add Order',
        ),
      ],
    );
  }
}
