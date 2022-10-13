import 'package:flutter/material.dart';
import 'package:flutterhw13/pages/login_page.dart';
import 'package:flutterhw13/pages/news_feed_page.dart';
import 'package:flutterhw13/services/user_service.dart';

import '../common/my_button.dart';
import '../common/my_text_field.dart';
import '../common/toast_loading_overlay.dart';
import '../common/toast_overlay.dart';
import '../services/api_service.dart';

class ChangePasswordPage extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? dob;
  final String? address;
  final String? email;
  final String? avtUrl;

  const ChangePasswordPage({super.key, this.name, this.phone, this.dob, this.address, this.email, this.avtUrl});


  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _rewritePasswordController;
  bool oldPwChecked = true;
  bool newPwChecked = true;
  bool renewPwChecked = true;

  @override
  void initState() {
    // TODO: implement initState
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _rewritePasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var widthM = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu'),
        // leading:
        //   IconButton(onPressed: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (_)=>const NewsFeedPage()));
        //   }, icon: const Icon(Icons.arrow_back_ios_new),),
        //
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //reverse: true,
        //physics: const NeverScrollableScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.symmetric(vertical: 32),
          //width: widthM,
          //height: heightM,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: SizedBox(
                    width: widthM / 2,
                    height: widthM / 2,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              MyTextField(
                text: 'Mật khẩu cũ',
                obscureText: true,
                autofocus: true,
                textEditingController: _oldPasswordController,
                onChanged: (String str){
                  if (str.length < 8 && str != '') {
                    setState(() {
                      oldPwChecked = false;
                    });
                  } else {
                    setState(() {
                      oldPwChecked = true;
                    });
                  }
                },
                inputCheck: oldPwChecked
                    ? ''
                    : 'Mật khẩu từ 8 ký tự trở lên',
              ),
              const SizedBox(
                height: 16,
              ),
              MyTextField(
                text: 'Mật khẩu mới',
                obscureText: true,
                textEditingController: _newPasswordController,
                onChanged: (String str){
                  if (str.length < 8 && str != '') {
                    setState(() {
                      newPwChecked = false;
                    });
                  } else {
                    setState(() {
                      newPwChecked = true;
                    });
                  }
                },
                inputCheck: newPwChecked
                    ? ''
                    : 'Mật khẩu từ 8 ký tự trở lên',
              ),
              const SizedBox(
                height: 16,
              ),
              MyTextField(
                text: 'Nhập lại mật khẩu mới',
                obscureText: true,
                textEditingController: _rewritePasswordController,
                onChanged: (String str){
                  if (str.length < 8 && str != '') {
                    setState(() {
                      renewPwChecked = false;
                    });
                  } else {
                    setState(() {
                      renewPwChecked = true;
                    });
                  }
                },
                inputCheck: renewPwChecked
                    ? ''
                    : 'Mật khẩu từ 8 ký tự trở lên',
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    onPressed: () {
                      updatePassword();
                    },
                    isEnable: true,
                    text: 'Xác nhận',
                    textColor: Colors.white,
                    width: widthM / 2.5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updatePassword(){
    ToastLoadingOverlay toastLoadingOverlay = ToastLoadingOverlay(context);
    if(_oldPasswordController.text==''||_newPasswordController.text==''||_rewritePasswordController.text==''){
      ToastOverlay(context).show(type: ToastType.warning,msg: 'Vui lòng điền đầy đủ thông tin');
    }else{
      if(oldPwChecked==true&&newPwChecked==true&&renewPwChecked){
        toastLoadingOverlay.show();
        Future.delayed(const Duration(seconds: 2),() async {
          await apiService
              .updatePassword(oldPassword: _oldPasswordController.text,newPassword: _newPasswordController.text)
              .then((value) {
            ToastOverlay(context).show(type: ToastType.success, msg: 'Thành công');

            toastLoadingOverlay.hide();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => NewsFeedPage(name: widget.name,phone: widget.phone,avtUrl: widget.avtUrl,dob: widget.dob,address: widget.address,email: widget.email,)));

          }).catchError((e) {
            print('$e');
            toastLoadingOverlay.hide();
            ToastOverlay(context).show(type: ToastType.error, msg: e.toString().replaceAll('Exception: ', ''));
          });
        });
      }else{
        ToastOverlay(context).show(type: ToastType.warning,msg: 'Vui lòng kiểm tra lại các thông tin');

      }


    }
  }
}
