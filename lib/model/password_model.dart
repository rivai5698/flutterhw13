class PasswordModel {
  PasswordModel({
      this.code, 
      this.message, 
      this.data,});

  PasswordModel.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
  int? code;
  String? message;
  dynamic data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['data'] = data;
    return map;
  }

}