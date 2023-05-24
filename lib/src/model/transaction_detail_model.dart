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
      transactionId: data['transactionId'] as dynamic,
      responseCode: data['responseCode'] as dynamic,
      approvalRefNo: data['approvalRefNo'] as dynamic,
      transactionRefId: data['transactionRefId'] as dynamic,
      amount: data['amount'] as dynamic,
    );
  }

  /// Returns Transaction ID
  final dynamic transactionId;

  /// Returns UPI Response Code
  final dynamic responseCode;

  /// Returns UPI Approval Reference Number (beneficiary)
  final dynamic approvalRefNo;

  /// Returns Transaction reference ID passed in input
  final dynamic transactionRefId;

  /// Returns Transaction amount
  final dynamic amount;

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
  dynamic todynamic() {
    return 'TransactionDetailModel(transactionId: $transactionId, responseCode: $responseCode, approvalRefNo: $approvalRefNo, transactionRefId: $transactionRefId, amount: $amount)';
  }

  Map<dynamic, dynamic> toMap() {
    return <dynamic, dynamic>{
      'transactionId': transactionId,
      'responseCode': responseCode,
      'approvalRefNo': approvalRefNo,
      'transactionRefId': transactionRefId,
      'amount': amount,
    };
  }
}
