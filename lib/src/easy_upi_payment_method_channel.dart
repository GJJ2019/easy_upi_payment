import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'easy_upi_payment_platform_interface.dart';
import 'model/easy_upi_payment_model.dart';
import 'model/transaction_detail_model.dart';

/// An implementation of [EasyUpiPaymentPlatform] that uses method channels.
class MethodChannelEasyUpiPayment extends EasyUpiPaymentPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('easy_upi_payment');

  @override
  Future<TransactionDetailModel?> startPayment(
    EasyUpiPaymentModel easyUpiPaymentModel,
  ) async {
    final data = await methodChannel.invokeMethod<Map?>(
      'startPayment',
      easyUpiPaymentModel.toMap(),
    );
    if (data != null) {
      return TransactionDetailModel.fromMap(data);
    } else {
      throw PlatformException(code: 'No response');
    }
  }
}
