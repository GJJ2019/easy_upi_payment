import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:easy_upi_payment/src/easy_upi_payment_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fake_data.dart';

class MockEasyUpiPaymentPlatform with MockPlatformInterfaceMixin implements EasyUpiPaymentPlatform {
  @override
  Future<TransactionDetailModel?> startPayment(EasyUpiPaymentModel easyUpiPaymentModel) {
    return Future.value(fakeTransactionDetailsModel);
  }
}

void main() {
  final EasyUpiPaymentPlatform initialPlatform = EasyUpiPaymentPlatform.instance;

  test('$MethodChannelEasyUpiPayment is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEasyUpiPayment>());
  });

  test('startPayment', () async {
    final MockEasyUpiPaymentPlatform fakePlatform = MockEasyUpiPaymentPlatform();
    EasyUpiPaymentPlatform.instance = fakePlatform;

    expect(await fakePlatform.startPayment(fakeEasyUpiPaymentModel), fakeTransactionDetailsModel);
  });
}
