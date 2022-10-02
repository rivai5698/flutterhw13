import 'package:flutter/material.dart';
import 'package:flutterhw13/common/my_button.dart';
import 'package:flutterhw13/common/my_text_field.dart';
import 'package:flutterhw13/pages/account_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var heightM = MediaQuery.of(context).size.height;
    var widthM = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.symmetric(vertical: 32),
          width: widthM,
          height: heightM,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: heightM/5,),
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
              const MyTextField(
               text: 'Số điện thoại',
               maxLength: 10,
               textInputType: TextInputType.phone,
                  ),
              const SizedBox(
               height: 16,
                  ),
              const MyTextField(
               text: 'Mật khẩu',
               maxLength: 24,
               obscureText: true,
                  ),

              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyButton(
                    onPressed: (){},
                    text: 'Đăng ký',
                    color: Colors.grey.shade100,
                    width: widthM / 2.5,
                    textColor: Colors.black,
                  ),
                  MyButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>AccountPage()));
                    },
                    text: 'Đăng nhập',
                    textColor: Colors.white,
                    width: widthM / 2.5,
                  ),
                ],
              ),
              Expanded(
                  child: SizedBox(
                    width: widthM,
                    height: heightM,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: 'Hotline: ',
                              style:  TextStyle(
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
                        //  const SizedBox(height: 16,)
                        ],
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
