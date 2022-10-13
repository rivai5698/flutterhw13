import 'package:flutterhw13/services/api_service.dart';
import 'package:image_picker/image_picker.dart';

import '../model/Photo.dart';

extension PhotoService on ApiService{
  Future<Photo> uploadImg({required XFile file}) async {
      final result = await request(path: '/api/upload',file: file,method: Method.post,);
      final photo = Photo.fromJson(result);
      return photo;
  }
}