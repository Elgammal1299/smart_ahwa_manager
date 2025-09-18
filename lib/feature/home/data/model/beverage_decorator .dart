import 'package:smart_ahwa_manager/feature/home/data/model/component_model.dart';

abstract class BeverageDecorator extends Beverage {
  final Beverage beverage;

  BeverageDecorator(this.beverage);

  @override
  String get description => beverage.description;
}

class Milk extends BeverageDecorator {
  Milk(super.beverage);

  @override
  String get description => "${beverage.description} + لبن";

  @override
  double cost() => beverage.cost() + 2.0;
}

class Mint extends BeverageDecorator {
  Mint(super.beverage);

  @override
  String get description => "${beverage.description} + نعناع";

  @override
  double cost() => beverage.cost() + 1.5;
}

class Sugar extends BeverageDecorator {
  Sugar(super.beverage);

  @override
  String get description => "${beverage.description} + سكر زيادة";

  @override
  double cost() => beverage.cost() + 1.0;
}
