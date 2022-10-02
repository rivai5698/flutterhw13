import 'package:flutter/material.dart';

class DrawerModel{
  IconData? icon;
  String? title;
  int? id;
  DrawerModel(this.icon, this.title, this.id);
}

List<DrawerModel> listDM = [
  DrawerModel(Icons.menu, 'Sự cố', 0),
  DrawerModel(Icons.report_gmailerrorred, 'Báo cáo',1),
  DrawerModel(Icons.shield_outlined, 'Đổi mật khẩu',2),
  DrawerModel(Icons.book_outlined, 'Điều khoản',3),
  DrawerModel(Icons.contact_mail_outlined, 'Liên hệ',4),
  DrawerModel(Icons.logout, 'Đăng xuất',5),
];

