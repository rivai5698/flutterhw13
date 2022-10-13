
import 'package:flutter/material.dart';
import 'package:flutterhw13/common/my_button.dart';
import 'package:flutterhw13/common/my_text_field.dart';
import 'package:flutterhw13/common/toast_overlay.dart';
import 'package:flutterhw13/pages/login_page.dart';
import 'package:flutterhw13/services/api_service.dart';
import 'package:flutterhw13/services/user_service.dart';

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
  late TextEditingController _rewritePasswordController;
  late TextEditingController _emailController;

  late bool isSuccess;
  bool isEmailChecked = true;
  bool isPhoneChecked = true;
  bool isPasswordChecked = true;
  bool isRePasswordChecked = true;

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  void initState() {
    // TODO: implement initState
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _rewritePasswordController = TextEditingController();
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
    _rewritePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var heightM = MediaQuery.of(context).size.height;
    var widthM = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký'),
      ),
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
                        autofocus: true,
                        text: 'Tên',
                        inputCheck: '',
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
                        onChanged: (String str) {
                          if (!isEmail(str) && str != '') {
                            setState(() {
                              isEmailChecked = false;
                            });
                            //ToastOverlay(context).show(type: ToastType.warning,msg: '');
                          } else {
                            setState(() {
                              isEmailChecked = true;
                            });
                          }
                        },
                        onSubmitted: (String str) {},
                        inputCheck: isEmailChecked ? '' : 'Sai định dạng email',
                        textEditingController: _emailController,
                        textInputType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyTextField(
                        text: 'Số điện thoại',
                        textInputAction: TextInputAction.next,
                        maxLength: 10,
                        onChanged: (String phone) {
                          if (!isPhone(phone) && phone != '') {
                            setState(() {
                              isPhoneChecked = false;
                            });
                          } else {
                            setState(() {
                              isPhoneChecked = true;
                            });
                          }
                        },
                        onSubmitted: (String str) {},
                        inputCheck: isPhoneChecked
                            ? ''
                            : 'Số điện thoại chưa đúng định dạng',
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
                        // onSubmitted: (String str){
                        //   register();
                        // },
                        inputCheck: isPasswordChecked
                            ? ''
                            : 'Mật khẩu từ 8 ký tự trở lên',
                        onChanged: (String str) {
                          if (str.length < 8 && str != '') {
                            setState(() {
                              isPasswordChecked = false;
                            });
                          } else {
                            setState(() {
                              isPasswordChecked = true;
                            });
                          }
                        },
                        textEditingController: _passwordController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyTextField(
                        text: 'Nhập lại mật khẩu',
                        maxLength: 24,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (String str) {
                          register();
                        },
                        inputCheck: isRePasswordChecked
                            ? ''
                            : 'Mật khẩu từ 8 ký tự trở lên',
                        onChanged: (String str) {
                          if (str.length < 8 && str != '') {
                            setState(() {
                              isRePasswordChecked = false;
                            });
                          } else {
                            setState(() {
                              isRePasswordChecked = true;
                            });
                          }
                        },
                        textEditingController: _rewritePasswordController,
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
                            color: Colors.blue,
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
                      color: Colors.blue,
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
    ToastLoadingOverlay toastLoadingOverlay = ToastLoadingOverlay(context);
    if (_emailController.text == '' ||
        _nameController.text == '' ||
        _passwordController.text == '' ||
        _rewritePasswordController.text == ''||
        _phoneController.text == '') {
      ToastOverlay(context).show(
        msg: 'Vui lòng điền đầy đủ thông tin',
        type: ToastType.warning,
      );
    } else {
      if (_rewritePasswordController.text != _passwordController.text) {
        ToastOverlay(context).show(
          msg: 'Mật khẩu không trùng khớp',
          type: ToastType.warning,
        );
      } else {
        if (isValidate()) {
          toastLoadingOverlay.show();
          Future.delayed(const Duration(seconds: 2), () async {
            await apiService
                .register(
                    phone: _phoneController.text,
                    password: _passwordController.text,
                    name: _nameController.text,
                    email: _emailController.text)
                .then((value) {
              Future.delayed(const Duration(seconds: 2), () {
                toastLoadingOverlay.hide();
                ToastOverlay(context)
                    .show(type: ToastType.success, msg: 'Thành công');
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => LoginPage(
                              phoneStr: _phoneController.text,
                              passwordStr: _passwordController.text,
                            )));
              });
            }).catchError((e) {
              toastLoadingOverlay.hide();
              ToastOverlay(context).show(
                  type: ToastType.error,
                  msg: e.toString().replaceAll('Exception: ', ''));
            });
          });
        }else{
          ToastOverlay(context).show(type: ToastType.warning,msg: 'Vui lòng kiểm tra lại các thông tin');
        }
      }
    }
  }

  bool isValidate() {
    if (isEmailChecked == true &&
        isPhoneChecked == true &&
        isPasswordChecked == true &&
        isRePasswordChecked == true)
    {
      return true;
    }
    return false;
  }

  bool isPhone(String phoneNumber) {
    final regExp = RegExp('(0)(3|5|7|8|9)+([0-9]{8})');
    return regExp.hasMatch(phoneNumber);
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }
}
