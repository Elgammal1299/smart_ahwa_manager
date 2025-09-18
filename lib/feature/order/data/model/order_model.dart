enum OrderStatus { pending, completed }

class OrderModel {
  final String customerName;
  final String drink;
  final String? addition;
  final int quantity;
  final double price;
  final OrderStatus status;

  OrderModel({
    required this.customerName,
    required this.drink,
    this.addition,
    required this.quantity,
    required this.price,
    this.status = OrderStatus.pending, // الافتراضي معلّق
  });

  OrderModel copyWith({
    String? customerName,
    String? drink,
    String? addition,
    int? quantity,
    double? price,
    OrderStatus? status,
  }) {
    return OrderModel(
      customerName: customerName ?? this.customerName,
      drink: drink ?? this.drink,
      addition: addition ?? this.addition,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }
}
