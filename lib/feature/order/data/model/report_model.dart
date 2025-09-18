class Report {
  final int totalOrders;
  final Map<String, int> topSellingDrinks; // ex: {"شاي": 5, "قهوة": 3}

  Report({required this.totalOrders, required this.topSellingDrinks});
}
