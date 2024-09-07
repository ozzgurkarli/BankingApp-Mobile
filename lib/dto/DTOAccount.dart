// ignore_for_file: non_constant_identifier_names

class DTOAccount
{
  int? Id;
  String? AccountNo;
  String? CustomerNo;
  String? Currency;
  String? CurrencyCode;
  double? Balance;
  bool? Primary;
  bool? Active;
  int? Branch;
  List? TransactionHistory;

  DTOAccount({this.Id, this.AccountNo, this.Currency, this.CurrencyCode, this.Balance, this.CustomerNo, this.Active, this.Branch, this.Primary, this.TransactionHistory});

  factory DTOAccount.fromJson(Map<dynamic, dynamic> json) {
    return DTOAccount(
      Id: json['id'] as int?,
      AccountNo: json['accountNo'] as String?,
      CustomerNo: json['customerNo'] as String?,
      CurrencyCode: json['currencyCode'] as String?,
      Currency: json['currency'] as String?,
      Balance: double.parse(json['balance'].toString()) as double?,
      Primary: json['primary'] as bool?,
      TransactionHistory: json['salary'] as List?,
      Branch: json['branch'] as int?,
      Active: json['active'] as bool?,
    );
  }

  // toJson metodu
  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'AccountNo': AccountNo,
      'CustomerNo': CustomerNo,
      'Balance': Balance,
      'CurrencyCode': CurrencyCode,
      'Primary': Primary,
      'TransactionHistory': TransactionHistory,
      'Currency': Currency,
      'Branch': Branch,
      'Active': Active,
    };
  }
}