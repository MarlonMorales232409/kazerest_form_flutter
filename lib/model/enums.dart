enum RestaurantType {
  fastFood,
  casualDining,
  fineDining,
  cafe,
  foodTruck,
  buffet,
  pub,
  bar,
  bakery,
  pizzeria,
  other,
}

extension RestaurantTypeSpanishExtension on RestaurantType {
  String get toSpanish {
    switch (this) {
      case RestaurantType.fastFood:
        return 'Comida rápida';
      case RestaurantType.casualDining:
        return 'Comida casual';
      case RestaurantType.fineDining:
        return 'Alta cocina';
      case RestaurantType.cafe:
        return 'Cafetería';
      case RestaurantType.foodTruck:
        return 'Camión de comida';
      case RestaurantType.buffet:
        return 'Bufé';
      case RestaurantType.pub:
        return 'Pub';
      case RestaurantType.bar:
        return 'Bar';
      case RestaurantType.bakery:
        return 'Panadería';
      case RestaurantType.pizzeria:
        return 'Pizzería';
      case RestaurantType.other:
        return 'Otro';
    }
  }
}