// ignore_for_file: non_constant_identifier_names

import 'package:parbank/api/ENV.dart';
import 'package:parbank/api/URequestTypes.dart';
import 'package:parbank/dto/CallerInformation.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:dio/dio.dart';

class UProxy {
  static Future<MessageContainer> Request(
      URequestTypes requestType, String path, MessageContainer message) async{
        UProxy _proxy = UProxy();
    final dio = Dio();
    dio.options.validateStatus = (status) {
      return status != null && status < 501;
    };
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${ENV.Token}";
    dio.options.headers['Identity-No'] = ENV.IdentityNo;
    late Response response;
    message.callerInformation = CallerInformation(ServiceName: path.split('.').first, OperationName: path.split('.').last);
    path = "InvokeOperation";
    message.Add("BankingApp.Infrastructure.Common.DataTransferObjects.CallerInformation", message.callerInformation);
    if(requestType == URequestTypes.GET){
      response = await _proxy.Get(dio, path, message);
    }else if(requestType == URequestTypes.POST){
      response = await _proxy.Post(dio, path, message);
    }else if(requestType == URequestTypes.PUT){
      response = await _proxy.Put(dio, path, message);
    }else if(requestType == URequestTypes.DELETE){

    }else{
      throw Exception("");
    }

    if(response.statusCode! > 299){
      throw Exception(response.data);
    }

    return requestType == URequestTypes.GET ? MessageContainer.fromJson(response.data["contents"]) : MessageContainer.fromJson(response.data);
  }

  Future<Response> Post(
      Dio dio, String path, MessageContainer message) async {
    final response =
        await dio.post(ENV.ConnectionString + path, data: message.toJson());

    return response;
  }

  Future<Response> Put(
      Dio dio, String path, MessageContainer message) async {
    final response =
        await dio.put(ENV.ConnectionString + path, data: message.toJson());

    return response;
  }

  Future<Response> Get(
      Dio dio, String path, MessageContainer message) async {
    final response =
        await dio.post(ENV.ConnectionString + path, data: message.toJson());

    return response;
  }
}
