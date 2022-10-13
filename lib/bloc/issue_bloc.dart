import 'dart:async';

import 'package:flutterhw13/services/api_service.dart';
import 'package:flutterhw13/services/issue_service.dart';

import '../model_2/IssuesData.dart';

class IssueBloc{
  final _issuesStreamController = StreamController<List<IssuesData>>();

  Stream<List<IssuesData>> get streamIssue => _issuesStreamController.stream;

  final issues = <IssuesData>[];

  IssueBloc(){
    getIssues();
  }



  Future<void> getIssues({bool isClear = false}) async {
    await Future.delayed(const Duration(seconds: 2),);
    await apiService.getIssues(limit: 5,offset: isClear ? 0 : issues.length).then((value){
      if(isClear){
        issues.clear();

        _issuesStreamController.add(issues);
      }
      if(value.isNotEmpty){
        issues.addAll(value);

        _issuesStreamController.add(issues);
      }

    }).catchError((e){
      _issuesStreamController.addError(e.toString());
    });
  }

}