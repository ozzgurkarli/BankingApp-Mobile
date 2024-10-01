// ignore_for_file: non_constant_identifier_names

class DTOParameter
{
  int? Id;
  String? GroupCode;
  int? Code;
  String? Description;
  String? Detail1;
  String? Detail2;
  String? Detail3;
  String? Detail4;
  String? Detail5;

  DTOParameter({this.Id, this.GroupCode, this.Code, this.Description, this.Detail1, this.Detail2, this.Detail3, this.Detail4, this.Detail5});

  factory DTOParameter.fromJson(Map<dynamic, dynamic> json) {
    return DTOParameter(
      Id: json['id'] as int?,
      GroupCode: json['groupCode'] as String?,
      Code: json['code'] as int?,
      Description: json['description'] as String?,
      Detail1: json['detail1'] as String?,
      Detail2: json['detail2'] as String?,
      Detail3: json['detail3'] as String?,
      Detail4: json['detail4'] as String?,
      Detail5: json['detail5'] as String?,
    );
  }

  // toJson metodu
  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'GroupCode': GroupCode,
      'Code': Code,
      'Description': Description,
      'Detail1': Detail1,
      'Detail2': Detail2,
      'Detail3': Detail3,
      'Detail4': Detail4,
      'Detail5': Detail5,
    };
  }
}