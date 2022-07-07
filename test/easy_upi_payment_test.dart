// import 'package:flutter_test/flutter_test.dart';
// import 'package:easy_upi_payment/easy_upi_payment.dart';
// import 'package:easy_upi_payment/easy_upi_payment_platform_interface.dart';
// import 'package:easy_upi_payment/easy_upi_payment_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockEasyUpiPaymentPlatform
//     with MockPlatformInterfaceMixin
//     implements EasyUpiPaymentPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final EasyUpiPaymentPlatform initialPlatform = EasyUpiPaymentPlatform.instance;
//
//   test('$MethodChannelEasyUpiPayment is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelEasyUpiPayment>());
//   });
//
//   test('getPlatformVersion', () async {
//     EasyUpiPayment easyUpiPaymentPlugin = EasyUpiPayment();
//     MockEasyUpiPaymentPlatform fakePlatform = MockEasyUpiPaymentPlatform();
//     EasyUpiPaymentPlatform.instance = fakePlatform;
//
//     expect(await easyUpiPaymentPlugin.getPlatformVersion(), '42');
//   });
// }
