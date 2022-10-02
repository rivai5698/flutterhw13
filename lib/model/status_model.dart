class StatusModel{
  String? username;
  String? dateCreate;
  String? title;
  bool? status;
  String? content;
  List<String>? imgUrls;

  StatusModel(this.username, this.dateCreate, this.title, this.status,
      this.content, this.imgUrls);
}

List <StatusModel> listSM =[
  StatusModel('Truong Huu Thang', '30/4/2022', 'Abc', true, 'content', [('assets/logo.png')]),
  StatusModel('Truong Huu Thang', '30/4/2022', 'Abc', false, 'content', [('assets/logo.png'),('assets/logo.png'),]),
  StatusModel('Truong Huu Thang', '1/5/2022', 'Abc', true, 'content', [('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),]),
  StatusModel('Truong Huu Thang', '2/6/2022', 'Abc', false, 'content', [('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),]),
  StatusModel('Truong Huu Thang', '3/7/2022', 'Abc', true, 'content', [('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),]),
  StatusModel('Truong Huu Thang', '3/9/2022', 'Abc', false, 'content', [('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),]),
  StatusModel('Truong Huu Thang', '3/10/2022', 'Abc', true, 'content', [('assets/logo.png')]),
  StatusModel('Truong Huu Thang', '30/11/2022', 'Abc', false, 'content', [('assets/logo.png')]),
  StatusModel('Truong Huu Thang', '30/12/2022', 'Abc', true, 'content', [('assets/logo.png')]),
  StatusModel('Truong Huu Thang', '1/1/2023', 'Abc', false, 'content', [('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),('assets/logo.png'),]),

];