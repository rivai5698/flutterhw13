import 'User.dart';

class Data {
  Data({
      this.code, 
      this.message, 
      this.data,});

  Data.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
  int? code;
  String? message;
  User? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['data'] = data;
    return map;
  }

}