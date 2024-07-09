class StripeApiConstants
{
  // token
  static const String token = 'Bearer sk_test_51Pa6FERuSVADrSkYUf2LSQIWDwwLnGEkYZpAkoSpT4Ox5FyFKtdO2WqBeBMHWr7Z9BpjdcirhBOaYpvUVvD64PVh00qnbQPHVD';
  static const String publishableKey = 'pk_test_51Pa6FERuSVADrSkYtHqgAlz4EuzgZ7ijxD7BRXKDRjfrUqqxTn270V25akP9bLroShv7WPnMvZmhbQhvd8FgTX3600HSA9g65r';

  //base url
  static const String baseUrl = 'https://api.stripe.com/v1/';


  // end points
  static const String createIntent = 'payment_intents';
  static const String createCustomer = 'customers';
  static const String getEphemeralKey = 'ephemeral_keys';
}