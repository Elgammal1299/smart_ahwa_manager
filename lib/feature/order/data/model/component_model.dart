abstract class Beverage {
  String get description;
  double cost();
}

class Tea extends Beverage {
  @override
  String get description => "شاي";

  @override
  double cost() => 5.0;
}

class Coffee extends Beverage {
  @override
  String get description => "قهوة";

  @override
  double cost() => 7.0;
}

class Juice extends Beverage {
  @override
  String get description => "عصير";

  @override
  double cost() => 10.0;
}

class Nescafe extends Beverage {
  @override
  String get description => "نسكافيه";

  @override
  double cost() => 12.0;
}
