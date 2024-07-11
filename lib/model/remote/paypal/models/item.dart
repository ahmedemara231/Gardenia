import '../../../../modules/data_types/plant.dart';

class Item
{
  String name;
  int quantity;
  String price;
  String currency;

  Item({
    required this.name,
    required this.quantity,
    required this.price,
    this.currency = 'USD'
  });

  factory Item.fromPlant({required Plant plant, required int quantity})
  {
    return Item(
        name: plant.name,
        quantity: quantity,
        price: plant.price.toString()
    );
  }

  Map<String,dynamic> toJson()
  {
    return
      {
        "name": name,
        "quantity": quantity,
        "price": price,
        "currency": currency
      };
  }
}