import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'easy_upi_payment_method_channel.dart';
import 'model/easy_upi_payment_model.dart';
import 'model/transaction_detail_model.dart';

abstract class EasyUpiPaymentPlatform extends PlatformInterface {
  /// Constructs a EasyUpiPaymentPlatform.
  EasyUpiPaymentPlatform() : super(token: _token);

  static final Object _token = Object();

  static EasyUpiPaymentPlatform _instance = MethodChannelEasyUpiPayment();

  /// The default instance of [EasyUpiPaymentPlatform] to use.
  ///
  /// Defaults to [MethodChannelEasyUpiPayment].
  static EasyUpiPaymentPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EasyUpiPaymentPlatform] when
  /// they register themselves.
  static set instance(EasyUpiPaymentPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<TransactionDetailModel?> startPayment(
    EasyUpiPaymentModel easyUpiPaymentModel,
  ) {
    throw UnimplementedError('startPayment() has not been implemented.');
  }
}
