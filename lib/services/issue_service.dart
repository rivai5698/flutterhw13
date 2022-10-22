import 'package:flutterhw13/model/Issues_data.dart';
import 'package:flutterhw13/services/api_service.dart';

extension IssueService on ApiService {
  Future<List<IssuesData>> getIssues({
    int limit = 10,
    required int offset,
  }) async {
    final result = await request(
        path: '/api/issues?limit=$limit&offset=$offset', method: Method.get);
    final issues =
        List<IssuesData>.from(result.map((e) => IssuesData.fromJson(e)));
    return issues;
  }

  Future<IssuesData> postIssue({
    required String title,
    required String content,
    required String photo,
  }) async {
    final body = {
      'Title': title,
      'Content': content,
      'Photos': photo,
    };

    final result =
        await request(path: '/api/issues', method: Method.post, body: body);
    final issues = IssuesData.fromJson(result);
    return issues;
  }
}
