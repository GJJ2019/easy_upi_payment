import 'package:easy_upi_payment/easy_upi_payment.dart';

const fakeTransactionDetailsModel = TransactionDetailModel(
  transactionId: 'transactionId',
  responseCode: 'responseCode',
  approvalRefNo: 'approvalRefNo',
  transactionRefId: 'transactionRefId',
  amount: 'amount',
);

const fakeEasyUpiPaymentModel = EasyUpiPaymentModel(
  payeeVpa: 'payeeVpa',
  payeeName: 'payeeName',
  amount: 10.0,
  description: 'description',
);
