// ignore_for_file: non_constant_identifier_names

class DTOTransactionHistory {
  int? Id;
  String? CustomerNo;
  String? AccountNo;
  String? CreditCardNo;
  double? Amount;
  double? MinAmount;
  double? MaxAmount;
  String? Currency;
  String? Description;
  int? TransactionType;
  DateTime? TransactionDate;
  DateTime? MaxDate;
  DateTime? MinDate;
  int? Count;

  DTOTransactionHistory(
      {this.Id,
      this.CustomerNo,
      this.AccountNo,
      this.CreditCardNo,
      this.Amount,
      this.Currency,
      this.TransactionType,
      this.Description,
      this.MinAmount,
      this.MaxAmount,
      this.MaxDate,
      this.MinDate,
      this.TransactionDate,
      this.Count});

  factory DTOTransactionHistory.fromJson(Map<dynamic, dynamic> json) {
    return DTOTransactionHistory(
      Id: json['id'] as int?,
      CustomerNo: json['customerNo'] as String?,
      AccountNo: json['accountNo'] as String?,
      CreditCardNo: json['creditCardNo'] as String?,
      Amount: double.parse(json['amount'].toString()) as double?,
      Currency: json['currency'] as String?,
      TransactionType: json['transactionType'] as int?,
      TransactionDate: DateTime.parse(json['transactionDate']) as DateTime?,
      MinDate: DateTime.parse(json['minDate'] ?? DateTime(1).toIso8601String()) as DateTime?,
      MaxDate: DateTime.parse(json['maxDate']?? DateTime(1).toIso8601String()) as DateTime?,
      Description: json['description'] as String?,
      Count: json['count'] as int?,
    );
  }

  // toJson metodu
  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'CustomerNo': CustomerNo,
      'AccountNo': AccountNo,
      'CreditCardNo': CreditCardNo,
      'Amount': Amount,
      'Currency': Currency,
      'TransactionType': TransactionType,
      'Description': Description,
      'TransactionDate': (TransactionDate ?? DateTime(1)).toIso8601String(),
      'MinDate': MinDate!.toIso8601String(),
      'MaxDate': (MaxDate ?? DateTime(1)).toIso8601String(),
      'Count': Count
    };
  }
}
