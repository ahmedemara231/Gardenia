class CreateIntentModel {
  String? id;
  String? object;
  num amount;
  num amount_capturable;
  var canceled_at;
  var cancellation_reason;
  String? capture_method;
  String? client_secret;
  String? confirmation_method;
  int created;
  String? currency;
  String? customer;
  String? invoice;

  CreateIntentModel({
    required this.id,
    required this.object,
    required this.amount,
    required this.amount_capturable,
    required this.canceled_at,
    required this.cancellation_reason,
    required this.capture_method,
    required this.client_secret,
    required this.confirmation_method,
    required this.created,
    required this.currency,
    required this.customer,
    required this.invoice
  });

  factory CreateIntentModel.fromJson(Map<String, dynamic> jsonData)
  {
    return CreateIntentModel(
        id: jsonData['id'],
        object: jsonData['object'],
        amount: jsonData['amount'],
        amount_capturable: jsonData['amount_capturable'],
        canceled_at: jsonData['canceled_at'],
        cancellation_reason: jsonData['cancellation_reason'],
        capture_method: jsonData['capture_method'],
        client_secret: jsonData['client_secret'],
        confirmation_method: jsonData['confirmation_method'],
        created: jsonData['created'],
        currency: jsonData['currency'],
        customer: jsonData['customer'],
        invoice: jsonData['invoice'],
    );
  }


}