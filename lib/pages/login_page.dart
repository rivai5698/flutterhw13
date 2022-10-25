import 'package:flutter/material.dart';
import 'package:flutterhw13/common/my_button.dart';
import 'package:flutterhw13/common/my_text_field.dart';
import 'package:flutterhw13/common/toast_loading_overlay.dart';
import 'package:flutterhw13/common/toast_overlay.dart';
import 'package:flutterhw13/pages/news_feed_page.dart';
import 'package:flutterhw13/pages/register_page.dart';
import 'package:flutterhw13/services/api_service.dart';
import 'package:flutterhw13/services/shared_preferences_manager.dart';
import 'package:flutterhw13/services/user_service.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late String name;
  late String phone;
  String? avtUrl;
  SharedPreferences? prefs;
  bool isPhoneChecked= true;
  bool isPasswordChecked= true;
  bool isClicked = false;
  bool pwInvisible = true;
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
    isEnable = false;
    _phoneController.text = widget.phoneStr;
    _passwordController.text = widget.passwordStr;
    initData();
    super.initState();
  }

  initData() async {
    final String? phone;
    phone = await sharedPrefs.getString('phone');
    if(_phoneController.text==''){
      _phoneController.text= phone ?? '';
    }
    final String? pw;
    pw = await sharedPrefs.getString('password');
    if(_passwordController.text==''){
      _passwordController.text= pw ?? '';
    }
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
                            child: LottieBuilder.asset('assets/logo.json'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyTextField(
                        autofocus: true,
                        text: 'Số điện thoại',
                        maxLength: 10,
                        readonly: isClicked,
                        textInputType: TextInputType.phone,
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
                        inputCheck: isPhoneChecked
                          ? ''
                          : 'Số điện thoại chưa đúng định dạng',
                        textEditingController: _phoneController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyTextField(
                        text: 'Mật khẩu',
                        obscureText: pwInvisible,
                        textInputAction: TextInputAction.done,
                        readonly: isClicked,
                        onSubmitted: (String str){
                          login();
                        },
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
                        icon: GestureDetector(
                          onTapDown: inContact,
                          onTapUp: outContact,
                          child: const Icon(
                            Icons.remove_red_eye,
                          ),
                        ),
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
                            textColor: Colors.white,
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
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const RegisterPage()) );
  }

  void login() {
    setState(() {
      isClicked = true;
    });
    final ToastLoadingOverlay toastOverlay = ToastLoadingOverlay(context);
    if(_phoneController.text==''||_passwordController.text==''){
      setState(() {
        isClicked = false;
      });
      ToastOverlay(context).show(type: ToastType.warning,msg: 'Vui lòng điền số điện thoại và mật khẩu');
    }else{
      if(isPhoneChecked==true&&isPasswordChecked==true){
        toastOverlay.show();

        Future.delayed(const Duration(seconds: 2),() async {
          await apiService
              .login(phone: _phoneController.text, password: _passwordController.text)
              .then((value) {
            ToastOverlay(context).show(type: ToastType.success, msg: 'Thành công');
            apiService.token = value.token!;
            setState(() {
              name = value.name!;
              phone = value.phoneNumber!;
              avtUrl = value.avatar;
            });

            //Future.delayed(const Duration(seconds: 5), () {
            sharedPrefs.setString('phone', _phoneController.text);
            sharedPrefs.setString('password', _passwordController.text);
            sharedPrefs.setString('apiKey', apiService.token);
            toastOverlay.hide();
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) =>  NewsFeedPage(name: name,phone: phone,avtUrl: avtUrl??'https://img.hoidap247.com/picture/user/20220203/tini_1643870739914.jpg',email: value.email,address: value.address??'',dob: value.dateOfBirth??'',)),(route)=>false);
            //});
            setState(() {
              isClicked = false;
            });
          }).catchError((e) {
            setState(() {
              isClicked = false;
            });
            toastOverlay.hide();
            ToastOverlay(context).show(type: ToastType.error, msg: e.toString().replaceAll('Exception: ', ''));
          });
        });
      }else{
        ToastOverlay(context).show(type: ToastType.warning,msg: 'Vui lòng kiểm tra lại các thông tin');
        setState(() {
          isClicked = false;
        });
      }


    }
  }

  bool isPhone(String phoneNumber) {
    final regExp = RegExp('(0)(3|5|7|8|9)+([0-9]{8})');
    return regExp.hasMatch(phoneNumber);
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
  void inContact(TapDownDetails details) {
    setState(() {
      pwInvisible = false;
    });
  }

  void outContact(TapUpDetails details) {
    setState(() {
      pwInvisible=true;
    });
  }
  void validate() {
    if (_phoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {}
  }
}
