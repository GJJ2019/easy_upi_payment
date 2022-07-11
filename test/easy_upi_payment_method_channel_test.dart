import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:easy_upi_payment/src/easy_upi_payment_method_channel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_data.dart';

void main() {
  final MethodChannelEasyUpiPayment platform = MethodChannelEasyUpiPayment();
  const MethodChannel channel = MethodChannel('easy_upi_payment');

  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  group('startPayment with appropriate result', () {
    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        return fakeTransactionDetailsModel.toMap();
      });
    });

    test('startPayment', () async {
      expect(await platform.startPayment(fakeEasyUpiPaymentModel),
          fakeTransactionDetailsModel);
    });
  });

  group('startPayment with exception', () {
    final platformException = PlatformException(
        code: EasyUpiPaymentExceptionType.failedException.toString());
    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        return platformException;
      });
    });

    test('startPayment', () async {
      expect(
        () => platform.startPayment(fakeEasyUpiPaymentModel),
        throwsA(isA<EasyUpiPaymentException>()),
      );
    });
  });
}
