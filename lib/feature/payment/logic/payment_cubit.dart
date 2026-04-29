import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/feature/payment/logic/payment_state.dart';


class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  Future<void> confirmSubscription() async {
    emit(PaymentLoading());

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // In the future, you will add your API call here
    // try {
    //   final response = await apiService.processPayment(...);
    //   emit(PaymentSuccess());
    // } catch (e) {
    //   emit(PaymentFailure(e.toString()));
    // }

    emit(PaymentSuccess());
  }
}
