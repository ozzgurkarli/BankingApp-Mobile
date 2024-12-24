// ignore_for_file: non_constant_identifier_names

class DTOLogin{
  int? Id;
  String? IdentityNo;
  int? Password;
  bool? Temporary;
  String? Token;
  String? NotificationToken;

  DTOLogin({this.Id, this.IdentityNo, this.Password, this.Temporary, this.Token, this.NotificationToken});

  factory DTOLogin.fromJson(Map<dynamic, dynamic> json) {
    return DTOLogin(
      Id: json['id'] as int?,
      IdentityNo: json['identityNo'] as String?,
      Password: int.parse(((json['password'] as String).length == 6 ? json['password'] as String : "100000")),
      Temporary: json['temporary'] as bool?,
      Token: json['token'] as String?,
      NotificationToken: json['notificationToken'] as String?
    );
  }

  // toJson metodu
  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'IdentityNo': IdentityNo,
      'Password': Password.toString(),
      'Temporary': Temporary,
      'NotificationToken': NotificationToken
    };
  }
}
