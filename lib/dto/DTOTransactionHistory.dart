// // ignore_for_file: non_constant_identifier_names

// class DTOTransactionHistory {
//   int? Id;
//   String? CustomerNo;
//   String? AccountNo;
//   String? CreditCardNo;
//   double? Amount;
//   String? Currency;
//   String? Description;
//   int? Password;

//   DTOTransactionHistory(
//       {this.Id,
//       this.CustomerNo,
//       this.AccountNo,
//       this.CreditCardNo,
//       this.Amount,
//       this.Currency,
//       this.Password,
//       this.Description});

//   factory DTOTransactionHistory.fromJson(Map<dynamic, dynamic> json) {
//     return DTOTransactionHistory(
//       Id: json['id'] as int?,
//       CustomerNo: json['customerNo'] as String?,
//       AccountNo: json['accountNo'] as String?,
//       CreditCardNo: json['creditCardNo'] as String?,
//       Amount: double.parse(json['amount'].toString()) as double?,
//       Currency: json['currency'] as String?,
//       Password: json['password'] as int?,
//       Description: json['description'] as String?,
//     );
//   }

//   // toJson metodu
//   Map<String, dynamic> toJson() {
//     return {
//       'Id': Id,
//       'CustomerNo': CustomerNo,
//       'AccountNo': AccountNo,
//       'CreditCardNo': CreditCardNo,
//       'Amount': Amount,
//       'Currency': Currency,
//       'Password': Password,
//       'Temporary': Temporary,
//     };
//   }
// }
