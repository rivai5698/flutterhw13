import 'package:flutter/material.dart';
import 'package:flutterhw13/common/const.dart';
import 'package:flutterhw13/common/group_image_dialog.dart';
import 'package:flutterhw13/common/image_dialog.dart';
import 'package:flutterhw13/common/my_dialog.dart';
import 'package:flutterhw13/common/photo_grid.dart';
import 'package:flutterhw13/model/Issues_data.dart';
import 'package:flutterhw13/pages/account_page.dart';
import 'package:flutterhw13/pages/change_password_page.dart';
import 'package:flutterhw13/pages/login_page.dart';
import 'package:flutterhw13/pages/report_page.dart';
import '../bloc/image_bloc.dart';
import '../bloc/issue_bloc.dart';
import '../model/drawer_model.dart' as dm;
import '../model/status_model.dart' as sm;

class NewsFeedPage extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? dob;
  final String? address;
  final String? email;
  final String? avtUrl;

  const NewsFeedPage(
      {super.key,
      this.name = '',
      this.phone = '',
      this.avtUrl = '',
      this.dob = '',
      this.email = '',
      this.address = ''});
  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  List<sm.StatusModel> sttM = [];
  List<dm.DrawerModel> drM = [];
  late IssueBloc issueBloc;
  late ImageBloc imageBloc;
  String? url;

  bool _showBackToTopButton = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true;
          } else {
            _showBackToTopButton = false;
          }
        });
      });
    url = widget.avtUrl;
    issueBloc = IssueBloc();
    imageBloc = ImageBloc();
    sttM.addAll(sm.listSM);
    drM.addAll(dm.listDM);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Sự cố'),
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue,
        width: MediaQuery.of(context).size.width / 1.25,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              _profileItem(
                widget.name ?? '',
                widget.phone ?? '',
                url ?? missingImgUrl,
              ),
              Expanded(
                child: ListView.separated(
                  //physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return _drawerItem(drM[index]);
                  },
                  itemCount: drM.length,
                  separatorBuilder: (_, index) {
                    return const Divider();
                  },
                ),
              )
            ],
          ),
        ),
      ),
      body: _postWidget(),

      // ListView.separated(
      //   shrinkWrap: true,
      //   itemBuilder: (_, index) {
      //     return _postWidget(sttM[index]);
      //   },
      //   separatorBuilder: (BuildContext context, int index) {
      //     return const SizedBox(
      //       height: 8,
      //     );
      //   },
      //   itemCount: sttM.length,
      // ),
    );
  }

  Widget _postWidget() {
    return StreamBuilder<List<IssuesData>>(
      stream: issueBloc.streamIssue,
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          final issues = snapshot.data ?? [];
          return RefreshIndicator(
            onRefresh: () async {
              await issueBloc.getIssues(isClear: true);
            },
            child: ListView.separated(
              controller: _scrollController,
              itemBuilder: (_, index) {
                if (index == issues.length - 1) {
                  issueBloc.getIssues(isClear: false);
                }
                return _item(issues[index]);
              },
              separatorBuilder: (_, index) {
                return const Divider();
              },
              itemCount: issues.length,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _item(IssuesData issue) {
    // var textStt = '';
    // if (statusModel.status == true) {
    //   textStt = 'Đã xong';
    // } else {
    //   textStt = 'Không duyệt';
    // }
    String issueUrl = '${issue.accountPublic!.avatar}';
    if (!issueUrl.startsWith('http') && issueUrl != '') {
      issueUrl = baseUrl + issueUrl;
      issueUrl = issueUrl.replaceAll(' ', '');
      if(issueUrl.contains('comuploads')){
        issueUrl= issueUrl.replaceAll('comuploads', 'com/uploads');
      }
    }

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const <BoxShadow>[
          BoxShadow(
              color: Colors.black54,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75))
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              // CircleAvatar(
              //   backgroundImage: issueUrl == '' || issueUrl == baseUrl
              //       ? const NetworkImage(missingImgUrl)
              //       : NetworkImage(issueUrl),
              // ),
              ClipOval(
                child: Image.network(issueUrl, fit: BoxFit.cover,
                    width: 32,
                    height: 32,
                    errorBuilder: (_, __, ___) {
                      return const Icon(Icons.error,color: Colors.redAccent,size: 25,);
                    }, loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    }),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    issue.createdBy!,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    issue.createdAt!,
                    style: const TextStyle(color: Colors.black26),
                  ),
                ],
              ),
              // Expanded(
              //   child: Align(
              //     alignment: Alignment.centerRight,
              //     child: Text(
              //       textStt,
              //       style: TextStyle(
              //           color: statusModel.status == true
              //               ? Colors.green
              //               : Colors.red),
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            color: Colors.grey,
            height: 1,
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  issue.title!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  issue.content!,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              // Image.asset(statusModel.imgUrl!),
              if (issue.photos!.isNotEmpty) ...[
                PhotoGrid(
                  imageUrls: issue.photos!,
                  onImageClicked: (i) {
                    ImageDialog(context).showImageDialog(issue.photos![i]);
                  },
                  onExpandClicked: (i) {
                    if (imageBloc.isClosed()) {
                      imageBloc = ImageBloc();
                    }
                    imageBloc.getIndex(i);
                    GroupImageDialog(context, imageBloc)
                        .showGroupImageDialog(issue.photos!, i);
                  },
                ),
              ] else ...[
                const SizedBox(
                  height: 0,
                ),
              ],
            ],
          )
        ],
      ),
    );
  }

  Widget _drawerItem(dm.DrawerModel drawerModel) {
    return GestureDetector(
      onTap: () {
        if (drawerModel.id == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const ReportPage()));
        } else if (drawerModel.id == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ChangePasswordPage(
                        name: widget.name,
                        phone: widget.phone,
                        avtUrl: widget.avtUrl,
                        dob: widget.dob,
                        address: widget.address,
                        email: widget.email,
                      )));
        } else if (drawerModel.id == 5) {
          MyDialog(context).showDialog(const LoginPage());

//          Navigator.pushReplacement(
//              context, MaterialPageRoute(builder: (_) => const LoginPage()));
        } else {}
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              drawerModel.icon,
              size: 24,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              drawerModel.title!,
              style: const TextStyle(color: Colors.black, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileItem(String name, String phone, String imgUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AccountPage(
                      name: widget.name,
                      phone: widget.phone,
                      avtUrl: url,
                      dob: widget.dob,
                      address: widget.address,
                      email: widget.email,
                    )));
      },
      child: Container(
        color: Colors.blue,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            height: 70,
            child: Row(
              children: [
                // CircleAvatar(
                //
                //   backgroundImage: NetworkImage(imgUrl),
                // ),
                ClipOval(
                  child: Image.network(imgUrl, fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                      errorBuilder: (_, __, ___) {
                        return const Icon(Icons.error,color: Colors.redAccent,size: 25,);
                      }, loadingBuilder: (_, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      }),
                ),



                const SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      phone,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),

                    //Text(phone),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 2), curve: Curves.linear);
  }
}
