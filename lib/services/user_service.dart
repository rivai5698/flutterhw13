import 'dart:convert';

import 'package:flutterhw13/model_2/ResponseData.dart';
import 'package:flutterhw13/services/api_service.dart';
import '../model/User.dart';
import 'package:flutterhw13/model/Data.dart';

extension UserService on ApiService{

  Future<User> login({
  required String phone,
    required String password,
}) async{
    final body = {
      "PhoneNumber" : phone,
      "Password": password,
    };
    final result = await request(
        path: '/api/accounts/login',
        body: body,
        method: Method.post,
    );
    final user = User.fromJson(result);
    return user;
  }


  Future<User> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async{
    final body = {
      "Name" : name,
      "PhoneNumber" : phone,
      "Email" : email,
      "Password": password,
    };
    final result = await request(
      path: '/api/accounts/register',
      body: body,
      method: Method.post,
    );
    final user = User.fromJson(result);
    print('register: ${user}');
    return user;
  }


}
