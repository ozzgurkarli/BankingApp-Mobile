// ignore_for_file: non_constant_identifier_names

class DTOLogin{
  int? Id;
  String? IdentityNo;
  int? Password;
  bool? Temporary;
  String? Token;

  DTOLogin({this.Id, this.IdentityNo, this.Password, this.Temporary, this.Token});

  factory DTOLogin.fromJson(Map<dynamic, dynamic> json) {
    return DTOLogin(
      Id: json['id'] as int?,
      IdentityNo: json['identityNo'] as String?,
      Password: json['password'] as int?,
      Temporary: json['temporary'] as bool?,
      Token: json['token'] as String?,
    );
  }

  // toJson metodu
  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'IdentityNo': IdentityNo,
      'Password': Password,
      'Temporary': Temporary,
    };
  }
}
