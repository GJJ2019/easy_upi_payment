import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'easy_upi_payment_test.mocks.dart';
import 'fake_data.dart';

@GenerateMocks([EasyUpiPaymentPlatform])
void main() {
  final mockPlatform = MockEasyUpiPaymentPlatform();

  test('startPayment', () async {
    when(mockPlatform.startPayment(fakeEasyUpiPaymentModel)).thenAnswer(
      (_) => Future.value(fakeTransactionDetailsModel),
    );
    expect(await mockPlatform.startPayment(fakeEasyUpiPaymentModel), fakeTransactionDetailsModel);
  });

  test('startPayment with cancelled Exception', () async {
    when(mockPlatform.startPayment(fakeEasyUpiPaymentModel)).thenThrow(
      EasyUpiPaymentException.fromException(
        PlatformException(
          code: EasyUpiPaymentExceptionType.cancelledException.toString(),
        ),
      ),
    );
    expect(
      () => mockPlatform.startPayment(fakeEasyUpiPaymentModel),
      throwsA(isA<EasyUpiPaymentException>()),
    );
  });

  test('startPayment with failed Exception', () async {
    when(mockPlatform.startPayment(fakeEasyUpiPaymentModel)).thenThrow(
      EasyUpiPaymentException.fromException(
        PlatformException(
          code: EasyUpiPaymentExceptionType.failedException.toString(),
        ),
      ),
    );
    expect(
      () => mockPlatform.startPayment(fakeEasyUpiPaymentModel),
      throwsA(isA<EasyUpiPaymentException>()),
    );
  });

  test('startPayment with submitted Exception', () async {
    when(mockPlatform.startPayment(fakeEasyUpiPaymentModel)).thenThrow(
      EasyUpiPaymentException.fromException(
        PlatformException(
          code: EasyUpiPaymentExceptionType.submittedException.toString(),
        ),
      ),
    );
    expect(
      () => mockPlatform.startPayment(fakeEasyUpiPaymentModel),
      throwsA(isA<EasyUpiPaymentException>()),
    );
  });

  test('startPayment with unknown Exception', () async {
    when(mockPlatform.startPayment(fakeEasyUpiPaymentModel)).thenThrow(
      EasyUpiPaymentException.fromException(
        PlatformException(
          code: EasyUpiPaymentExceptionType.unknownException.toString(),
        ),
      ),
    );
    expect(
      () => mockPlatform.startPayment(fakeEasyUpiPaymentModel),
      throwsA(isA<EasyUpiPaymentException>()),
    );
  });
}
