class AmountModel
{
  String total;
  String currency;
  Details details;

  AmountModel({
    required this.total,
    this.currency = 'USD',
    required this.details
  });

  Map<String,dynamic> toJson()
  {
    return
      {
        'total' : total,
        'currency' : currency,
        'details' : details..toJson(),
      };
  }

}
class Details
{
  String subTotal;
  String shipping;
  num shipping_discount;

  Details({
    required this.subTotal,
    required this.shipping,
    required this.shipping_discount
  });

  Map<String,dynamic> toJson()
  {
    return
      {
        "subtotal": subTotal,
        "shipping": shipping,
        "shipping_discount": shipping_discount
      };
  }
}