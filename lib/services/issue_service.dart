import 'package:flutterhw13/model_2/IssuesData.dart';
import 'package:flutterhw13/services/api_service.dart';

extension IssueService on ApiService{
  Future<List<IssuesData>> getIssues({
  int limit = 10,
    required int offset,
}) async{
    final result = await request(path: '/api/issues?limit=$limit&offset=$offset',method: Method.get);
    final issues = List<IssuesData>.from(result.map((e)=> IssuesData.fromJson(e)));
    return issues;
}
}