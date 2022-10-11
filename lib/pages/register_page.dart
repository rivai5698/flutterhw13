import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterhw13/common/const.dart';
import 'package:flutterhw13/common/my_button.dart';
import 'package:flutterhw13/common/my_text_field.dart';
import 'package:flutterhw13/common/toast_overlay.dart';
import 'package:flutterhw13/pages/account_page.dart';
import 'package:flutterhw13/pages/login_page.dart';
import 'package:flutterhw13/services/api_service.dart';
import 'package:flutterhw13/services/user_service.dart';
import 'package:http/http.dart' as http;

import '../common/toast_loading_overlay.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;

  late bool isSuccess;
  @override
  void initState() {
    // TODO: implement initState
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    isSuccess = false;
    //_phoneController.text = '0944556692';
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var heightM = MediaQuery.of(context).size.height;
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
                            text: 'Tên',
                            textInputAction: TextInputAction.next,
                            textEditingController: _nameController,
                            textInputType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextField(
                            text: 'Email',
                            textInputAction: TextInputAction.next,
                            textEditingController: _emailController,
                            textInputType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextField(
                            text: 'Số điện thoại',
                            textInputAction: TextInputAction.next,
                            maxLength: 10,
                            textInputType: TextInputType.phone,
                            textEditingController: _phoneController,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextField(
                            text: 'Mật khẩu',
                            textInputAction: TextInputAction.done,
                            maxLength: 24,
                            obscureText: true,
                            onSubmitted: (String str){
                              register();
                            },
                            textEditingController: _passwordController,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyButton(
                                onPressed: () => register(),
                                text: 'Đăng ký',
                                isEnable: true,
                                color: Colors.green,
                                width: widthM / 2.5,
                                textColor: Colors.white,
                              ),
                              // MyButton(
                              //   onPressed: () {
                              //     print('_LoginPageState.build');
                              //     login();
                              //
                              //   },
                              //   // {
                              //   //   login();
                              //   //    Navigator.push(context,
                              //   //        MaterialPageRoute(builder: (_) => const AccountPage()));
                              //   // }
                              //   isEnable: true,
                              //   text: 'Đăng nhập',
                              //   textColor: Colors.white,
                              //   width: widthM / 2.5,
                              // ),
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
    print('_RegisterPageState.register');
    ToastLoadingOverlay(context).show();
    apiService.register(phone: _phoneController.text,password: _passwordController.text,name: _nameController.text,email: _emailController.text).then((value){
      Future.delayed(const Duration(seconds: 2),(){
        ToastOverlay(context).show(type: ToastType.success,msg: 'Thành công');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>  LoginPage(phoneStr: _phoneController.text,passwordStr: _passwordController.text,)));
      });

    }).catchError((e){
      ToastOverlay(context).show(type: ToastType.error,msg:'That bai');
    });
  }

  // Future<void> login() async {
  //   final uri = Uri.parse("http://api.quynhtao.com/api/accounts/register");
  //
  //   final parameters = {
  //     "Name": _nameController.text,
  //     "Email": _emailController.text,
  //     "PhoneNumber": _phoneController.text,
  //     "Password": _passwordController.text,
  //
  //   };
  //
  //   final response = await http.post(
  //     uri,
  //     body: parameters,
  //     encoding: utf8,
  //   );
  //   final json = jsonDecode(response.body);
  //   if (json['code'] == 0) {
  //     isSuccess = true;
  //     ToastOverlay(context).show(type: ToastType.success,msg: 'Đăng ký thành công');
  //     Future.delayed(Duration(seconds: 2),(){
  //       Navigator.pop(context);
  //     });
  //   } else {
  //     isSuccess = false;
  //     ToastOverlay(context).show(type: ToastType.error,msg: json['message']);
  //     //throw Exception('Error');
  //   }
  //
  //   print(response.body);
  // }

  void validate() {
    if (_phoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {}
  }
}
