import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gardenia/model/local/secure_storage.dart';
import 'package:gardenia/model/remote/stripe/api_service/models/create_intent_input_model.dart';
import 'package:gardenia/model/remote/stripe/api_service/models/create_intent_model.dart';
import 'package:gardenia/model/remote/stripe/repositories/post_repo.dart';
import 'package:gardenia/view_model/stripe/states.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../model/remote/api_service/service/error_handling/errors.dart';
import '../../model/remote/stripe/api_service/service/stripe_connection.dart';

class StripeCubit extends Cubit<StripeStates>
{
  StripeCubit() : super(StripeInitialState());

  factory StripeCubit.getInstance(context) => BlocProvider.of(context);

  final StripePostRepo stripePostRepo = StripePostRepo(
      apiService: StripeConnection.getInstance()
  );

  Future<Result<CreateIntentModel, CustomError>> createPaymentIntent({
    required CreateIntentInputModel inputModel
})async
  {
    final data = await stripePostRepo.createPaymentIntent(
        inputModel: inputModel
    );

    return data;
  }

  Future<String> createEphemeralKey()async
  {
    final key = await stripePostRepo.createEphemeralKey();
    return key.getOrThrow();
  }

  Future<void> initPaymentSheet(var paymentIntentClientSecret) async {
    // 1. create payment intent on the server
    // final data = await _createTestPaymentSheet();

    // 2. initialize the payment sheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        // Set to true for custom flow
        // customFlow: false,

        // Main params
        merchantDisplayName: 'Gardenia Store',
        paymentIntentClientSecret: paymentIntentClientSecret,

        // Customer keys
        customerId: 'cus_QRO74OeDrsV4D1',
        customerEphemeralKeySecret: await createEphemeralKey(),
        // customerId: await SecureStorage.getInstance().readData(key: '')

        // Extra options
        // applePay: const PaymentSheetApplePay(
        //   merchantCountryCode: 'US',
        // ),
        // googlePay: const PaymentSheetGooglePay(
        //   merchantCountryCode: 'US',
        //   testEnv: true,
        // ),
      ),
    );
  }

  Future<void> presentPaymentSheet()async
  {
    await Stripe.instance.presentPaymentSheet();
  }

  Future<void> makePaymentProcess({
    required CreateIntentInputModel inputModel
  })async
  {
    emit(StripePaymentLoading());
    await createPaymentIntent(inputModel: inputModel).then((result)async {
      if(result.isSuccess())
        {
          await initPaymentSheet(result.getOrThrow().client_secret);
          await presentPaymentSheet();
          emit(StripePaymentSuccess());
        }
      else{
        emit(StripePaymentError());
      }
    });
  }
}