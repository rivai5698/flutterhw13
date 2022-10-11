import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterhw13/common/my_button.dart';
import 'package:flutterhw13/common/my_text_field.dart';
import 'package:flutterhw13/common/toast_loading_overlay.dart';
import 'package:flutterhw13/common/toast_overlay.dart';
import 'package:flutterhw13/pages/news_feed_page.dart';
import 'package:flutterhw13/pages/register_page.dart';
import 'package:flutterhw13/services/api_service.dart';
import 'package:flutterhw13/services/user_service.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  final String phoneStr, passwordStr;

  const LoginPage({super.key, this.phoneStr = '', this.passwordStr = ''});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late bool isEnable;
  @override
  void initState() {
    // TODO: implement initState
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    isEnable = false;
    _phoneController.text = widget.phoneStr;
    _passwordController.text = widget.passwordStr;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var heightM = MediaQuery.of(context).size.height;
    var widthM = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                        text: 'Số điện thoại',
                        maxLength: 10,
                        textInputType: TextInputType.phone,
                        textEditingController: _phoneController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyTextField(
                        text: 'Mật khẩu',
                        maxLength: 24,
                        obscureText: true,
                        textEditingController: _passwordController,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyButton(
                            onPressed: () => register(),
                            text: 'Đăng ký',
                            color: Colors.grey.shade100,
                            width: widthM / 2.5,
                            textColor: Colors.black,
                          ),
                          MyButton(
                            onPressed: () {
                              print('_LoginPageState.build');
                              login();
                            },
                            isEnable: true,
                            text: 'Đăng nhập',
                            textColor: Colors.white,
                            width: widthM / 2.5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            RichText(
              text: const TextSpan(
                text: 'Hotline: ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: '1800.1186',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void register() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const RegisterPage()));
  }

  void login() {
    if(_phoneController.text==''||_passwordController.text==''){
      ToastOverlay(context).show(type: ToastType.warning,msg: 'Vui lòng điền số điện thoại và mật khẩu');
    }else{
      ToastLoadingOverlay(context).show();
      apiService
          .login(phone: _phoneController.text, password: _passwordController.text)
          .then((value) {
        ToastOverlay(context).show(type: ToastType.success, msg: 'Thành công');
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const NewsFeedPage()));
        });
      }).catchError((e) {
        ToastOverlay(context).show(type: ToastType.error, msg: 'That bai');
      });
    }

  }

  // Future<void> login() async {
  //   final uri = Uri.parse("http://api.quynhtao.com/api/accounts/login");
  //
  //   final parameters = {
  //     "PhoneNumber": _phoneController.text,
  //     "Password": _passwordController.text,
  //   };
  //
  //   await Future.delayed(Duration.zero,(){
  //     ToastLoadingOverlay(context).show();
  //   });
  //
  //   final response = await http.post(
  //     uri,
  //     body: parameters,
  //     encoding: utf8,
  //   );
  //
  //
  //
  //   final json = jsonDecode(response.body);
  //   if(json['code']==0){
  //     ToastOverlay(context).show(type: ToastType.success,msg: 'Đăng nhập thành công');
  //     Future.delayed(const Duration(seconds: 2),(){
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const NewsFeedPage()));
  //     });
  //     isEnable = true;
  //   }else{
  //     isEnable = false;
  //     ToastOverlay(context).show(msg: json['message']);
  //     //throw Exception('Error');
  //   }
  //   print(response.body);
  // }

  void validate() {
    if (_phoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {}
  }
}
