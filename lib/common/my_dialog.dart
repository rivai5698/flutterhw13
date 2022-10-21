import 'package:flutter/material.dart';
import 'package:flutterhw13/pages/login_page.dart';

import '../services/shared_preferences_manager.dart';

class MyDialog{
  final BuildContext context;

  MyDialog(this.context);

  void showDialog(Widget materialPage){
    showGeneralDialog(
        barrierDismissible: false,
        barrierColor: Colors.grey.withOpacity(0.2),
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        context: context,
        pageBuilder: (_, __, ___) {
          return Container(
            alignment: Alignment.center,
            child: Material(
              color: Colors.transparent,
              child: _myDialog(materialPage),
            ),
          );
        });
  }

  Widget _myDialog(Widget materialPage) {
    return Container(
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Đăng xuất',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 10,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Xác nhận đăng xuất?',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          height: 40,
                          child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Huỷ',
                                style: TextStyle(color: Colors.blue),
                              ),),),
                    ),),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      sharedPrefs.remove('apiKey');
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> materialPage), (route) => false);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.blue,
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Đồng ý',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}