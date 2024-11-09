// ignore_for_file: non_constant_identifier_names

class DTOCreditCard
{
  int? Id;
  String? CardNo;
  String? CustomerNo;
  double? Limit;
  double? CurrentDebt;
  double? TotalDebt;
  double? OutstandingBalance;
  double? TypeFee;
  bool? Active;
  int? Type;
  String? TypeName;
  int? CVV;
  int? BillingDay;
  DateTime? ExpirationDate;
  DateTime? AccountClosingDate;
  DateTime? NextAccountClosingDate;
  int? InstallmentCount;
  double? Amount;
  String? TransactionCompany;

  DTOCreditCard({this.Id, this.CardNo, this.Limit, this.TypeFee, this.TypeName, this.CVV, this.AccountClosingDate, this.NextAccountClosingDate, this.CustomerNo, this.Active, this.TotalDebt, this.CurrentDebt, this.Type, this.ExpirationDate, this.BillingDay, this.OutstandingBalance, this.Amount, this.InstallmentCount, this.TransactionCompany});

  factory DTOCreditCard.fromJson(Map<dynamic, dynamic> json) {
    return DTOCreditCard(
      Id: json['id'] as int?,
      CardNo: json['cardNo'] as String?,
      CustomerNo: json['customerNo'] as String?,
      TypeName: json['typeName'] as String?,
      Limit: json['limit'] as double?,
      OutstandingBalance: json['outstandingBalance'] as double?,
      TotalDebt: double.parse(json['totalDebt'].toString()) as double?,
      CurrentDebt: double.parse(json['currentDebt'].toString()) as double?,
      Type: json['type'] as int?,
      CVV: json['cvv'] as int?,
      BillingDay: json['billingDay'] as int?,
      Active: json['active'] as bool?,
      ExpirationDate: DateTime.parse(json['expirationDate']) as DateTime?,
      AccountClosingDate: DateTime.parse(json['accountClosingDate'] ?? DateTime(1).toIso8601String()) as DateTime?,
      NextAccountClosingDate: DateTime.parse(json['nextAccountClosingDate'] ?? DateTime(1).toIso8601String()) as DateTime?,
      TypeFee: double.parse(json['typeFee'].toString() != "null" ? json['typeFee'].toString() : "0") as double?,
      Amount: double.parse(json['amount'].toString() != "null" ? json['amount'].toString() : "0") as double?,
      InstallmentCount: json['installmentCount'] as int?,
      TransactionCompany: json['TransactionCompany'] as String?,
    );
  }

  // toJson metodu
  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'CardNo': CardNo,
      'CustomerNo': CustomerNo,
      'OutstandingBalance': OutstandingBalance,
      'Type': Type,
      'CVV': CVV,
      'BillingDay': BillingDay,
      'ExpirationDate': ExpirationDate,
      'Limit': Limit,
      'Active': Active,
      'CurrentDebt': CurrentDebt,
      'InstallmentCount': InstallmentCount,
      'Amount': Amount,
      'TypeFee': TypeFee,
      'NextAccountClosingDate': NextAccountClosingDate,
      'AccountClosingDate': AccountClosingDate,
      'TransactionCompany': TransactionCompany,
      'TotalDebt': TotalDebt
    };
  }
}