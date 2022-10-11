import 'dart:convert';
import 'package:flutterhw13/common/const.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService _apiService = ApiService._internal();

  factory ApiService() => _apiService;
  ApiService._internal();

  Future request({
    Method method = Method.get,
    required String path,
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse(baseUrl + path);

    http.Response response;

    switch (method) {
      case Method.get:
        response = await http.get(uri);
        break;
      case Method.delete:
        response = await http.delete(uri, encoding: utf8);
        break;
      case Method.put:
        response = await http.put(uri, encoding: utf8);
        break;
      default:
        response = await http.post(uri, body: body, encoding: utf8);
        break;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body);
      if (json['code'] == 0) {
        final data = json['data'];
        return data;
      } else {
        throw Exception(json['message']);
      }
    }
    throw Exception('Error : ${response.statusCode}');
  }
}

final apiService = ApiService();

enum Method {
  get,
  post,
  put,
  delete,
}
