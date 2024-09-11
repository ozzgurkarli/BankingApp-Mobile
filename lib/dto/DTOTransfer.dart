// ignore_for_file: non_constant_identifier_names

class DTOTransfer
{
  int? Id;
  String? SenderAccount;
  String? SenderCustomerNo;
  String? RecipientAccount;
  String? Currency;
  double? Amount;
  int? SenderAccountId;
  int? Status;
  DateTime? TransactionDate;
  DateTime? OrderDate;

  DTOTransfer({this.Id, this.SenderAccount, this.Currency, this.SenderAccountId, this.SenderCustomerNo, this.RecipientAccount, this.Amount, this.Status, this.TransactionDate, this.OrderDate});

  factory DTOTransfer.fromJson(Map<dynamic, dynamic> json) {
    return DTOTransfer(
      Id: json['id'] as int?,
      SenderAccount: json['senderAccount'] as String?,
      SenderCustomerNo: json['senderCustomerNo'] as String?,
      RecipientAccount: json['recipientAccount'] as String?,
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
      'SenderAccount': SenderAccount,
      'RecipientAccount': RecipientAccount,
      'SenderCustomerNo': SenderCustomerNo,
      'Amount': Amount,
      'SenderAccountId': SenderAccountId,
      'TransactionDate': TransactionDate,
      'OrderDate': OrderDate!.toIso8601String(),
      'Status': Status,
      'Currency': Currency,
    };
  }
}