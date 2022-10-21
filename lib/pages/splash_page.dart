import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterhw13/common/toast_overlay.dart';
import 'package:flutterhw13/model/user.dart';
import 'package:flutterhw13/pages/login_page.dart';
import 'package:flutterhw13/pages/news_feed_page.dart';
import 'package:flutterhw13/services/api_service.dart';
import 'package:flutterhw13/services/shared_preferences_manager.dart';
import 'package:flutterhw13/services/user_service.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}


class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    initData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LottieBuilder.asset('assets/loading.json',width: MediaQuery.of(context).size.width-100,),
      ),
    );
  }

  Future initData() async{
    await sharedPrefs.init();
    String? phone = await sharedPrefs.getString('phone');
    String? password = await sharedPrefs.getString('password');
    
    if(await sharedPrefs.getString('apiKey')==null){
      await Future.delayed(const Duration(seconds: 3),(){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginPage()), (route) => false);
      });
    }else{
      await Future.delayed(const Duration(seconds: 3),(){
        apiService.login(phone: phone!,password: password!).then((value){
          apiService.token=value.token!;
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>NewsFeedPage(name: value.name,phone: value.phoneNumber,avtUrl: value.avatar,address: value.address,dob: value.dateOfBirth,email: value.email,)), (route) => false);
        }).catchError((e){
          ToastOverlay(context).show(msg: e.toString(),);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LoginPage(phoneStr: phone!,passwordStr: password!,)), (route) => false);

        });
      });
    }
    


  }
}
