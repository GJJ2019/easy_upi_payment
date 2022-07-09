import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainStateNotifier extends StateNotifier<MainState> {
  MainStateNotifier() : super(MainState.initial);

  TransactionDetailModel? transactionDetailModel;

  /// for starting payment
  Future<void> startPayment(EasyUpiPaymentModel model) async {
    state = MainState.loading;
    try {
      //
      final res = await EasyUpiPaymentPlatform.instance.startPayment(model);
      if (res != null) {
        transactionDetailModel = res;
        state = MainState.success;
      } else {
        state = MainState.error;
      }
    } on EasyUpiPaymentException {
      state = MainState.error;
    }
  }
}

final mainStateProvider = StateNotifierProvider.autoDispose<MainStateNotifier, MainState>(
  (ref) {
    return MainStateNotifier();
  },
);

enum MainState {
  initial,
  loading,
  success,
  error,
}
