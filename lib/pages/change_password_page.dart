import 'package:flutter/material.dart';
import 'package:flutterhw13/pages/news_feed_page.dart';

import '../common/my_button.dart';
import '../common/my_text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _rewritePasswordController;

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
                textEditingController: _oldPasswordController,
              ),
              const SizedBox(
                height: 16,
              ),
              MyTextField(
                text: 'Mật khẩu mới',
                textInputType: TextInputType.phone,
                textEditingController: _newPasswordController,
              ),
              const SizedBox(
                height: 16,
              ),
              MyTextField(
                text: 'Nhập lại mật khẩu mới',
                textInputType: TextInputType.phone,
                textEditingController: _rewritePasswordController,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyButton(
                    onPressed: () => {
                      Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_)=> const NewsFeedPage()))
                    },
                    text: 'Từ chối',
                    color: Colors.grey.shade100,
                    width: widthM / 2.5,
                    textColor: Colors.black,
                  ),
                  MyButton(
                    onPressed: () {
                      print('_LoginPageState.build');
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
}
