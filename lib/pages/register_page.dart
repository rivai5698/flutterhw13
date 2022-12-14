import 'package:flutter/material.dart';
import 'package:flutterhw13/common/my_button.dart';
import 'package:flutterhw13/common/my_text_field.dart';
import 'package:flutterhw13/common/toast_overlay.dart';
import 'package:flutterhw13/services/api_service.dart';
import 'package:flutterhw13/services/user_service.dart';
import 'package:lottie/lottie.dart';

import '../common/const.dart';
import '../common/toast_loading_overlay.dart';
import '../services/shared_preferences_manager.dart';
import 'login_page.dart';
import 'news_feed_page.dart';

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
  bool isClicked = false;
  bool pwInvisible1 = true;
  bool pwInvisible2 = true;

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
        title: const Text('????ng k??'),
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
                            child: Lottie.asset('assets/logo.json'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyTextField(
                        autofocus: true,
                        text: 'T??n',
                        inputCheck: '',
                        readonly: isClicked,
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
                        readonly: isClicked,
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
                        inputCheck: isEmailChecked ? '' : 'Sai ?????nh d???ng email',
                        textEditingController: _emailController,
                        textInputType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyTextField(
                        text: 'S??? ??i???n tho???i',
                        readonly: isClicked,
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
                            : 'S??? ??i???n tho???i ch??a ????ng ?????nh d???ng',
                        textInputType: TextInputType.phone,
                        textEditingController: _phoneController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyTextField(
                        text: 'M???t kh???u',
                        textInputAction: TextInputAction.done,
                        readonly: isClicked,
                        maxLength: 24,
                        obscureText: pwInvisible1,
                        // onSubmitted: (String str){
                        //   register();
                        // },
                        inputCheck: isPasswordChecked
                            ? ''
                            : 'M???t kh???u t??? 8 k?? t??? tr??? l??n',
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
                        icon: GestureDetector(
                          onTapDown: inContact1,
                          onTapUp: outContact1,
                          child: const Icon(
                            Icons.remove_red_eye,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyTextField(
                        text: 'Nh???p l???i m???t kh???u',
                        readonly: isClicked,
                        maxLength: 24,
                        obscureText: pwInvisible2,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (String str) {
                          register();
                        },
                        inputCheck: isRePasswordChecked
                            ? ''
                            : 'M???t kh???u t??? 8 k?? t??? tr??? l??n',
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
                        icon: GestureDetector(
                          onTapDown: inContact2,
                          onTapUp: outContact2,
                          child: const Icon(
                            Icons.remove_red_eye,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                            onPressed: () => register(),
                            text: '????ng k??',
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
                          //   text: '????ng nh???p',
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
    setState(() {
      isClicked = true;
    });
    ToastLoadingOverlay toastLoadingOverlay = ToastLoadingOverlay(context);
    if (_emailController.text == '' ||
        _nameController.text == '' ||
        _passwordController.text == '' ||
        _rewritePasswordController.text == '' ||
        _phoneController.text == '') {
      setState(() {
        isClicked = false;
      });
      ToastOverlay(context).show(
        msg: 'Vui l??ng ??i???n ?????y ????? th??ng tin',
        type: ToastType.warning,
      );
    } else {
      if (_rewritePasswordController.text != _passwordController.text) {
        ToastOverlay(context).show(
          msg: 'M???t kh???u kh??ng tr??ng kh???p',
          type: ToastType.warning,
        );
        setState(() {
          isClicked = false;
        });
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
                sharedPrefs.setString('phone', _phoneController.text);
                sharedPrefs.setString('password', _passwordController.text);
                sharedPrefs.setString('apiKey', apiService.token);
                ToastOverlay(context)
                    .show(type: ToastType.success, msg: 'Th??nh c??ng');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => NewsFeedPage(
                              name: _nameController.text,
                              phone: _phoneController.text,
                              avtUrl: value.avatar ?? missingImgUrl,
                              email: value.email,
                              //address: value.address ?? '',
                              dob: value.dateOfBirth ?? '',
                            )),
                    (route) => false);
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (_) => LoginPage(
                //               phoneStr: _phoneController.text,
                //               passwordStr: _passwordController.text,
                //             )));
              });
              setState(() {
                isClicked = false;
              });
            }).catchError((e) {
              setState(() {
                isClicked = false;
              });
              toastLoadingOverlay.hide();
              if(e.toString().replaceAll('Exception: ', '')=='S??? ??i???n tho???i ???? ???????c ????ng k??'){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => LoginPage(
                              phoneStr: _phoneController.text,
                              passwordStr: _passwordController.text,
                            )));
                ToastOverlay(context).show(
                    type: ToastType.info,
                    msg:'S??? ??i???n tho???i ???? ???????c ????ng k?? vui l??ng ????ng nh???p',
                );
              }else{
                ToastOverlay(context).show(
                    type: ToastType.error,
                    msg: e.toString().replaceAll('Exception: ', ''));
              }
            });
          });
        } else {
          setState(() {
            isClicked = false;
          });
          ToastOverlay(context).show(
              type: ToastType.warning,
              msg: 'Vui l??ng ki???m tra l???i c??c th??ng tin');
        }
      }
    }
  }

  void inContact1(TapDownDetails details) {
    setState(() {
      pwInvisible1 = false;
    });
  }

  void outContact1(TapUpDetails details) {
    setState(() {
      pwInvisible1=true;
    });
  }

  void inContact2(TapDownDetails details) {
    setState(() {
      pwInvisible2 = false;
    });
  }

  void outContact2(TapUpDetails details) {
    setState(() {
      pwInvisible2=true;
    });
  }

  bool isValidate() {
    if (isEmailChecked == true &&
        isPhoneChecked == true &&
        isPasswordChecked == true &&
        isRePasswordChecked == true) {
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
