import 'dart:convert';

import 'package:education_app/src/core/errors/exceptions.dart';
import 'package:education_app/src/core/utils/constants.dart';
import 'package:education_app/src/core/utils/typedef.dart';
import 'package:education_app/src/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:education_app/src/features/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._client);
  final http.Client _client;
  static const createUserEndPoint = 'users';
  static const getUserEndPoint = 'users';
  @override
  Future<void> createUser({
    required String avatar,
    required String createdAt,
    required String name,
  }) async {
    // TODO: implement createUser
    // 1. we need to check that it returns the right data when the response code is 2xx.
    // 2. check to make sure that throws a custom exception when the response code is 4xx, 5xx.

    try {
      final response = await _client.post(
        Uri.parse(kBaseUrl + AuthRemoteDataSourceImpl.createUserEndPoint),
        body: jsonEncode(
          {
            'avatar': avatar,
            'createdAt': createdAt,
            'name': name,
          },
        ),
      );
      if (!_requestIsSuccessfull(response.statusCode)) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException catch (e) {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.parse(kBaseUrl + AuthRemoteDataSourceImpl.createUserEndPoint),
      );

      if (!_requestIsSuccessfull(response.statusCode)) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      final answer = (jsonDecode(response.body) as List<dynamic>)
          .map((el) => UserModel.fromMap(el))
          .toList();
      return answer;
    } on APIException catch (e) {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  bool _requestIsSuccessfull(int statusCode) {
    if (statusCode >= 200 && statusCode <= 299) return true;
    return false;
  }
}
