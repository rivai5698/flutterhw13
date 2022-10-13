import 'dart:convert';
import 'package:flutterhw13/common/const.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ApiService {
  static final ApiService _apiService = ApiService._internal();

  factory ApiService() => _apiService;
  ApiService._internal();
  var token = '';
  Future request({
    Method method = Method.get,
    required String path,
    Map<String, dynamic>? body,
    XFile? file,
  }) async {
    final uri = Uri.parse(baseUrl + path);

    http.Response response;

    final headers = {
      "Authorization" : "Bearer $token",
    };

    if(file!=null){
      final request = http.MultipartRequest("Post", uri);
      request.headers.addAll(headers);
      request.files.add(
        http.MultipartFile.fromBytes('file', await file.readAsBytes(),filename: file.path.split('/').last),
      );
      final stream = await request.send();

      response = await http.Response.fromStream(stream);

    }else{
      switch (method) {
        case Method.get:
          response = await http.get(uri, headers: headers);
          break;
        case Method.delete:
          response = await http.delete(uri, encoding: utf8,headers: headers);
          break;
        case Method.put:
          response = await http.put(uri, encoding: utf8,headers: headers);
          break;
        default:
          response = await http.post(uri, body: body, encoding: utf8,headers: headers);
          break;
      }
    }


    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body);
      if (json['code'] == 0) {
        final data = json['data'];
        return data;
      } else {
        print('${json['message']}');
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
