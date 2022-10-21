
import 'package:flutterhw13/model/password_model.dart';
import 'package:flutterhw13/services/api_service.dart';
import '../model/user.dart';

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
    return user;
  }

  Future<User> update({required String name,
          required String dob,
          required String address,
          required String email,
          bool? gender,
          String? avtUrl,
  }) async {
    final body = {
      "Name": name,
      "DateOfBirth" : dob,
      "Address" : address,
      "Avatar" : avtUrl,
      "Email" : email
    };
   
    final result = await request(path: '/api/accounts/update',method: Method.post,body: body);
    final user = User.fromJson(result);
    return user;
  }

  Future<bool>updatePassword({required String oldPassword, required String newPassword}) async {
    final body = {
      "OldPassword" : oldPassword,
      "NewPassword" : oldPassword
    };

    final result = await request(path: '/api/accounts/changePassword',method: Method.post,body: body);
    //final pModel = PasswordModel.fromJson(result);
    return result;

  }

}
