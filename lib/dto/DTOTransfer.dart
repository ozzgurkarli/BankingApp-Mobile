// ignore_for_file: non_constant_identifier_names

class DTOTransfer
{
  int? Id;
  String? SenderAccountNo;
  String? SenderCustomerNo;
  String? RecipientAccountNo;
  String? Currency;
  double? Amount;
  int? SenderAccountId;
  int? Status;
  DateTime? TransactionDate;
  DateTime? OrderDate;

  DTOTransfer({this.Id, this.SenderAccountNo, this.Currency, this.SenderAccountId, this.SenderCustomerNo, this.RecipientAccountNo, this.Amount, this.Status, this.TransactionDate, this.OrderDate});

  factory DTOTransfer.fromJson(Map<dynamic, dynamic> json) {
    return DTOTransfer(
      Id: json['id'] as int?,
      SenderAccountNo: json['senderAccountNo'] as String?,
      SenderCustomerNo: json['senderCustomerNo'] as String?,
      RecipientAccountNo: json['recipientAccountNo'] as String?,
      Amount: double.parse(json['amount'].toString()) as double?,
      Currency: json['currency'] as String?,
      SenderAccountId: json['senderAccountId'] as int?,
      TransactionDate: DateTime.parse(json['transactionDate']) as DateTime?,
      OrderDate: DateTime.parse(json['orderDate']) as DateTime?,
      Status: json['status'] as int?
    );
  }

  // toJson metodu
  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'SenderAccountNo': SenderAccountNo,
      'RecipientAccountNo': RecipientAccountNo,
      'SenderCustomerNo': SenderCustomerNo,
      'Amount': Amount,
      'SenderAccountId': SenderAccountId,
      'TransactionDate': TransactionDate,
      'OrderDate': (OrderDate ?? DateTime(1)).toIso8601String(),
      'Status': Status,
      'Currency': Currency,
    };
  }
}