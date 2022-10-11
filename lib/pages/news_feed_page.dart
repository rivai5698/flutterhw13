import 'package:flutter/material.dart';
import 'package:flutterhw13/common/my_dialog.dart';
import 'package:flutterhw13/common/photo_grid.dart';
import 'package:flutterhw13/pages/change_password_page.dart';
import 'package:flutterhw13/pages/login_page.dart';
import 'package:flutterhw13/pages/report_page.dart';

import '../model/drawer_model.dart' as dm;
import '../model/status_model.dart' as sm;

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({Key? key}) : super(key: key);

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  List<sm.StatusModel> sttM = [];
  List<dm.DrawerModel> drM = [];
  @override
  void initState() {
    // TODO: implement initState
    sttM.addAll(sm.listSM);
    drM.addAll(dm.listDM);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Sự cố'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue,
        width: MediaQuery.of(context).size.width / 1.25,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              _profileItem('Truong Huu Thang', '0859685545', 'assets/logo.png'),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return _drawerItem(drM[index]);
                },
                itemCount: drM.length,
                separatorBuilder: (_, index) {
                  return const Divider();
                },
              )
            ],
          ),
        ),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return _postWidget(sttM[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 8,
          );
        },
        itemCount: sttM.length,
      ),
    );
  }

  Widget _postWidget(sm.StatusModel statusModel) {
    var textStt = '';
    if (statusModel.status == true) {
      textStt = 'Đã xong';
    } else {
      textStt = 'Không duyệt';
    }
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusModel.username!,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    statusModel.dateCreate!,
                    style: const TextStyle(color: Colors.black26),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    textStt,
                    style: TextStyle(
                        color: statusModel.status == true
                            ? Colors.green
                            : Colors.red),
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.grey,
            height: 1,
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  statusModel.title!,
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
                  statusModel.content!,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              // Image.asset(statusModel.imgUrl!),
              PhotoGrid(
                  imageUrls: statusModel.imgUrls!,
                  onImageClicked: (i){},
                  onExpandClicked: (){},
                  )
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
        }else if (drawerModel.id == 2) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const ChangePasswordPage()));
        }
        else if (drawerModel.id == 5) {
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
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 60,
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  imgUrl,
                ),
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
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    phone,
                    style: const TextStyle(
                      fontSize: 16,
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
    );
  }
}
