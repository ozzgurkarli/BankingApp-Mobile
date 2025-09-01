// ignore_for_file: non_constant_identifier_names

class CallerInformation
{
  String? ServiceName;
  String? OperationName;

  CallerInformation({this.ServiceName, this.OperationName});

  factory CallerInformation.fromJson(Map<dynamic, dynamic> json) {
    return CallerInformation(
      ServiceName: json['serviceName'] as String?,
      OperationName: json['operationName'] as String?,
    );
  }

  // toJson metodu
  Map<String, dynamic> toJson() {
    return {
      'ServiceName': ServiceName,
      'OperationName': OperationName
    };
  }
}