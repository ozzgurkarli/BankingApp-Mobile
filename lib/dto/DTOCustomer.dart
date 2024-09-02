// ignore_for_file: non_constant_identifier_names

class DTOCustomer
{
  int? Id;
  String? IdentityNo;
  String? CustomerNo;
  String? Name;
  String? Surname;
  String? PrimaryMailAddress;
  String? PhoneNo;
  double? Salary;
  int? CreditScore;
  int? Gender;
  bool? Active;
  int? Profession;
  int? Branch;

  DTOCustomer({this.Id, this.IdentityNo, this.CreditScore, this.Salary, this.CustomerNo, this.Active, this.Branch, this.Gender, this.Name, this.PhoneNo, this.PrimaryMailAddress, this.Profession, this.Surname});

  factory DTOCustomer.fromJson(Map<dynamic, dynamic> json) {
    return DTOCustomer(
      Id: json['id'] as int?,
      IdentityNo: json['identityNo'] as String?,
      CustomerNo: json['customerNo'] as String?,
      Name: json['name'] as String?,
      Surname: json['surname'] as String?,
      PhoneNo: json['phoneNo'] as String?,
      Salary: json['salary'] as double?,
      PrimaryMailAddress: json['primaryMailAddress'] as String?,
      Profession: json['profession'] as int?,
      Branch: json['branch'] as int?,
      CreditScore: json['creditScore'] as int?,
      Active: json['active'] as bool?,
      Gender: json['gender'] as int?,
    );
  }

  // toJson metodu
  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'IdentityNo': IdentityNo,
      'CustomerNo': CustomerNo,
      'Name': Name,
      'Surname': Surname,
      'PhoneNo': PhoneNo,
      'PrimaryMailAddress': PrimaryMailAddress,
      'Profession': Profession,
      'Salary': Salary,
      'Branch': Branch,
      'CreditScore': CreditScore,
      'Active': Active,
      'Gender': Gender,
    };
  }
}