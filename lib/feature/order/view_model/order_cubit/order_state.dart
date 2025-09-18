part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}
class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final List<OrderModel> pending;
  final List<OrderModel> completed;

  OrderSuccess({
    required this.pending,
    required this.completed,
  });
}


class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}