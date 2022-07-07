import 'dart:developer';

import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: startTransaction,
                  child: const Text("Pay Now"),
                ),
        ),
      ),
    );
  }

  bool _isLoading = false;

  Future<void> startTransaction() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final transactionDetail = await EasyUpiPaymentPlatform.instance.startPayment(
        EasyUpiPaymentModel(
          // TODO: add payeeVpa
          payeeVpa: 'gaurav.jajoo@upi',
          // TODO: add payeeName
          payeeName: 'Gaurav Jajoo',
          // TODO: add amount
          amount: '1.0',
          description: 'donate to Ram Mandir',
        ),
      );

      log(transactionDetail.toString());
    } on PlatformException catch (e) {
      log('exception is $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
