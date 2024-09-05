// ignore_for_file: non_constant_identifier_names

class DTOCreditCard
{
  int? Id;
  String? CardNo;
  String? CustomerNo;
  double? Limit;
  double? CurrentDebt;
  double? OutstandingBalance;
  bool? Active;
  int? Type;
  String? TypeName;
  int? CVV;
  int? BillingDay;
  DateTime? ExpirationDate;

  DTOCreditCard({this.Id, this.CardNo, this.Limit, this.TypeName, this.CVV, this.CustomerNo, this.Active, this.CurrentDebt, this.Type, this.ExpirationDate, this.BillingDay, this.OutstandingBalance});

  factory DTOCreditCard.fromJson(Map<dynamic, dynamic> json) {
    return DTOCreditCard(
      Id: json['id'] as int?,
      CardNo: json['cardNo'] as String?,
      CustomerNo: json['customerNo'] as String?,
      TypeName: json['typeName'] as String?,
      Limit: json['limit'] as double?,
      OutstandingBalance: json['outstandingBalance'] as double?,
      CurrentDebt: double.parse(json['currentDebt'].toString()) as double?,
      Type: json['type'] as int?,
      CVV: json['cvv'] as int?,
      BillingDay: json['billingDay'] as int?,
      Active: json['active'] as bool?,
      ExpirationDate: DateTime.parse(json['expirationDate']) as DateTime?,
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
    };
  }
}