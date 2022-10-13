import 'package:flutterhw13/model_2/IssuesData.dart';
import 'package:flutterhw13/services/api_service.dart';

extension IssueService on ApiService{
  Future<IssuesData> postIssue({
    required String title,
    required String content,
    required String photo,
  }) async{
    
    final body = {
      'Title' : title,
      'Content' : content,
      'Photos' : photo,
    };
    
    final result  = await request(path: '/api/issues',method: Method.post,body: body);
    final issues = IssuesData.fromJson(result);
    return issues;
  }
}