import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ahwa_manager/feature/home/data/model/order_model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  final List<OrderModel> _pendingOrders = [];
  final List<OrderModel> _completedOrders = [];

  List<OrderModel> get pendingOrders => List.unmodifiable(_pendingOrders);
  List<OrderModel> get completedOrders => List.unmodifiable(_completedOrders);

  void addOrder(OrderModel order) {
    _pendingOrders.add(order);
    emit(OrderSuccess(pending: pendingOrders, completed: completedOrders));
  }

  void completeOrder(int index) {
    final order = _pendingOrders.removeAt(index);
    _completedOrders.add(order);
    emit(OrderSuccess(pending: pendingOrders, completed: completedOrders));
  }

  void removeOrder(int index, {bool fromPending = true}) {
    if (fromPending) {
      _pendingOrders.removeAt(index);
    } else {
      _completedOrders.removeAt(index);
    }
    emit(OrderSuccess(pending: pendingOrders, completed: completedOrders));
  }

  void getOrders() {
    emit(OrderSuccess(pending: pendingOrders, completed: completedOrders));
  }

  Map<String, dynamic> getReports() {
  final allOrders = [..._pendingOrders, ..._completedOrders];

  final totalRevenue = allOrders.fold<double>(
    0.0,
    (sum, order) => sum + order.price,
  );

  final drinksCount = <String, int>{};
  for (var order in allOrders) {
    drinksCount[order.drink] =
        (drinksCount[order.drink] ?? 0) + order.quantity;
  }
  final topDrink = drinksCount.entries.isNotEmpty
      ? drinksCount.entries.reduce((a, b) => a.value > b.value ? a : b)
      : null;

  final additionsCount = <String, int>{};
  for (var order in allOrders) {
    if (order.addition != null) {
      additionsCount[order.addition!] =
          (additionsCount[order.addition!] ?? 0) + order.quantity;
    }
  }
  final topAddition = additionsCount.entries.isNotEmpty
      ? additionsCount.entries.reduce((a, b) => a.value > b.value ? a : b)
      : null;

  return {
    "totalRevenue": totalRevenue,
    "topDrink": topDrink?.key,
    "topDrinkCount": topDrink?.value,
    "topAddition": topAddition?.key,
    "topAdditionCount": topAddition?.value,
  };
}

}
