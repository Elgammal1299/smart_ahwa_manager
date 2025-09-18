import 'package:flutter/material.dart';

class CustomDrinksDropdown extends StatelessWidget {
  final List<String> drinks;
  final String? selectedDrink;
  final ValueChanged<String?> onChanged;

  const CustomDrinksDropdown({
    super.key,
    required this.drinks,
    required this.selectedDrink,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedDrink,
      items: drinks
          .map((drink) => DropdownMenuItem(value: drink, child: Text(drink)))
          .toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Choose a drink",
      ),
    );
  }
}

/// ويدجيت الإضافات
class AdditionsDropdown extends StatelessWidget {
  final List<String> additions;
  final String? selectedAddition;
  final ValueChanged<String?> onChanged;

  const AdditionsDropdown({
    super.key,
    required this.additions,
    required this.selectedAddition,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedAddition,
      items: additions
          .map(
            (addition) =>
                DropdownMenuItem(value: addition, child: Text(addition)),
          )
          .toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Choose an addition",
      ),
    );
  }
}
