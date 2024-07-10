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