import 'package:flutter/material.dart';
import 'package:flutterhw13/common/my_button.dart';
import 'package:flutterhw13/common/my_text_field.dart';
import 'package:flutterhw13/pages/news_feed_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late TextEditingController _textEditingController;
  var isEnable;
  @override
  void initState() {
    // TODO: implement initState
    _textEditingController = TextEditingController();
    isEnable = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var heightM = MediaQuery.of(context).size.height;
    var widthM = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
      ),
      body: GestureDetector(
        //onTap: Keyboard,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          reverse: true,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              children: [
                SizedBox(
                  width: widthM,
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 125,
                      width: 125,
                      child: Stack(
                        children: [
                          const Positioned.fill(
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/logo.png'),
                            ),
                          ),
                          Positioned(
                              right: 0,
                              bottom: 0,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 30,
                                ),
                                color: Colors.green,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                MyTextField(
                  text: 'Họ & tên',
                  textCapitalization: TextCapitalization.words,
                  textEditingController: _textEditingController,
                ),
                const SizedBox(
                  height: 16,
                ),
                MyTextField(
                  text: 'Ngày sinh',
                  textInputType: TextInputType.datetime,
                  textEditingController: _textEditingController,
                ),
                const SizedBox(
                  height: 16,
                ),
                MyTextField(
                  text: 'Địa chỉ',
                  textCapitalization: TextCapitalization.words,
                  textEditingController: _textEditingController,
                ),
                const SizedBox(
                  height: 16,
                ),
                MyTextField(
                  text: 'Email',
                  textInputType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  textEditingController: _textEditingController,
                ),
                const SizedBox(
                  height: 32,
                ),
                MyButton(
                  text: 'Lưu',
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => NewsFeedPage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
