// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:parbank/api/ENV.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:dio/dio.dart';

class UProxy {
  static Future<MessageContainer> Post(
      String path, MessageContainer message) async {
    final dio = Dio();
    dio.options.validateStatus = (status) {
      return status != null && status < 501;
    };

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${ENV.Token}";

    final response =
        await dio.post(ENV.ConnectionString + path, data: message.toJson());

    if (response.statusCode! > 299) {
      throw Exception(response.data);
    }

    return MessageContainer.fromJson(response.data);
  }

  static Future<MessageContainer> Put(
      String path, MessageContainer message) async {
    final dio = Dio();
    dio.options.validateStatus = (status) {
      return status != null && status < 501;
    };

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${ENV.Token}";

    final response =
        await dio.put(ENV.ConnectionString + path, data: message.toJson());

    if (response.statusCode! > 299) {
      throw Exception(response.data);
    }

    return MessageContainer.fromJson(response.data);
  }

  static Future<MessageContainer> Get(
      String path, MessageContainer message) async {
    final dio = Dio();
    dio.options.validateStatus = (status) {
      return status != null && status < 501;
    };

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${ENV.Token}";

    final response =
        await dio.post(ENV.ConnectionString + path, data: message.toJson());

    if (response.statusCode! > 299) {
      throw Exception(response.data);
    }

    return MessageContainer.fromJson(response.data["contents"]);
  }
}
