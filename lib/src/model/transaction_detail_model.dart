// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransactionDetailModel {
  const TransactionDetailModel({
    required this.transactionId,
    required this.responseCode,
    required this.approvalRefNo,
    required this.transactionRefId,
    required this.amount,
  });

  factory TransactionDetailModel.fromMap(Map data) {
    return TransactionDetailModel(
      transactionId: data['transactionId'] as String,
      responseCode: data['responseCode'] as String,
      approvalRefNo: data['approvalRefNo'] as String,
      transactionRefId: data['transactionRefId'] as String,
      amount: data['amount'] as String,
    );
  }

  /// Returns Transaction ID
  final String? transactionId;

  /// Returns UPI Response Code
  final String? responseCode;

  /// Returns UPI Approval Reference Number (beneficiary)
  final String? approvalRefNo;

  /// Returns Transaction reference ID passed in input
  final String? transactionRefId;

  /// Returns Transaction amount
  final String? amount;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionDetailModel &&
        other.transactionId == transactionId &&
        other.responseCode == responseCode &&
        other.approvalRefNo == approvalRefNo &&
        other.transactionRefId == transactionRefId &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return transactionId.hashCode ^
        responseCode.hashCode ^
        approvalRefNo.hashCode ^
        transactionRefId.hashCode ^
        amount.hashCode;
  }

  @override
  String toString() {
    return 'TransactionDetailModel(transactionId: $transactionId, responseCode: $responseCode, approvalRefNo: $approvalRefNo, transactionRefId: $transactionRefId, amount: $amount)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactionId': transactionId,
      'responseCode': responseCode,
      'approvalRefNo': approvalRefNo,
      'transactionRefId': transactionRefId,
      'amount': amount,
    };
  }
}
