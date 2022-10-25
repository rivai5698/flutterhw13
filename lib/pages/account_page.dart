import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutterhw13/common/my_button.dart';
import 'package:flutterhw13/common/my_text_field.dart';
import 'package:flutterhw13/pages/news_feed_page.dart';
import 'package:flutterhw13/services/api_service.dart';
import 'package:flutterhw13/services/photo_service.dart';
import 'package:flutterhw13/services/user_service.dart';
import 'package:image_picker/image_picker.dart';

import '../common/const.dart';
import '../common/toast_loading_overlay.dart';
import '../common/toast_overlay.dart';

class AccountPage extends StatefulWidget {

  final String? name;
  final String? phone;
  final String? dob;
  final String? address;
  final String? email;
  final String? avtUrl;

  const AccountPage({super.key, required this.name, this.dob, this.address, this.email, this.avtUrl, required this.phone});




  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final ImagePicker _picker = ImagePicker();
   String? name;
   String? phone;
   String? dob;
   String? address;
   String? email;
   String? avtUrl;


  late TextEditingController _nameController;
  late TextEditingController _dobController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  XFile? file;
  String? url;

  bool isEmailChecked=true;

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  @override
  void initState() {
    // TODO: implement initState
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _emailController = TextEditingController();
    _dobController = TextEditingController();
    url = widget.avtUrl??'';
    _nameController.text = widget.name??'';
    _dobController.text = widget.dob??'';
    _addressController.text = widget.address??'';
    _emailController.text = widget.email??'';

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var heightM = MediaQuery.of(context).size.height;

    var widthM = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.symmetric(vertical: 32),
                //width: widthM,
                //height: heightM,
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
                               Positioned.fill(
                                child:
                                ClipOval(
                                  child: Image.network(url!, fit: BoxFit.cover,
                                      width: 32,
                                      height: 32,
                                      errorBuilder: (_, __, ___) {
                                        return const Icon(Icons.error,color: Colors.redAccent,size: 25,);
                                      }, loadingBuilder: (_, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      }),
                                ),
                                // CircleAvatar(
                                //   //backgroundImage: AssetImage(widget.avtUrl ?? 'assets/logo.png'),
                                //   backgroundImage: url == null||url=='' ?  const NetworkImage('https://img.hoidap247.com/picture/user/20220203/tini_1643870739914.jpg') : NetworkImage(url!)
                                //   //const AssetImage('assets/logo.png'),
                                // ),
                              ),
                              Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      selImage(source: ImageSource.gallery);
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 30,
                                    ),
                                    color: Colors.white,
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
                      textEditingController: _nameController,
                      inputCheck: '',
                      autofocus: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MyTextField(
                      readonly: true,
                      onTap: (){
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(1930,1,1),
                          maxTime: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
                          currentTime: _dobController.text=='' ? DateTime.now() : textToDate(_dobController.text) ,
                          onChanged: (date){

                          },
                          onConfirm: (date){
                              _dobController.text = '${date.day.toString().length<2? '0${date.day}' :date.day}/${date.month.toString().length<2 ? '0${date.month}' :date.month}/${date.year}';
                          },
                          locale: LocaleType.vi,
                        );
                      },
                      text: 'Ngày sinh',
                      inputCheck: '',
                      textInputType: TextInputType.datetime,
                      textEditingController: _dobController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MyTextField(
                      text: 'Địa chỉ',
                      textCapitalization: TextCapitalization.words,
                      textEditingController: _addressController,
                      inputCheck: '',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MyTextField(
                      text: 'Email',
                      textInputType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      textEditingController: _emailController,
                      onChanged: (String str){
                        if(!isEmail(str)&&str!=''){
                          setState(() {
                            isEmailChecked = false;
                          });
                        }else{
                          setState(() {
                            isEmailChecked = true;
                          });
                        }
                      },
                      inputCheck: isEmailChecked ? '': 'Email chưa đúng định dạng',
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    MyButton(
                      text: 'Lưu',
                      textColor: Colors.white,
                      isEnable: true,
                      onPressed: () {
                        update();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future selImage({required ImageSource source}) async{
    try{
      final img = await _picker.pickImage(source: source);

      if(img!=null){
        updateAvt(img);
      }
    }catch(e){
      // getLostData();
      ToastOverlay(context).show(msg: 'Error: $e');
      //print('$e');
    }


  }

  void updateAvt(XFile file){
    ToastLoadingOverlay toastLoadingOverlay = ToastLoadingOverlay(context);
    if(file!=null){
      toastLoadingOverlay.show();
      Future.delayed(const Duration(seconds: 2),() async {
        await apiService.uploadImg(file: file).then((value){
          ToastOverlay(context).show(msg: 'Thành công',type: ToastType.success);
          print(value.path);
          setState(() {
            url = '$baseUrl${value.path}';
            print('$url');
          });
          toastLoadingOverlay.hide();
        }).catchError((e){
          toastLoadingOverlay.hide();
          ToastOverlay(context).show(msg: e.toString().replaceAll('Exception: ', ''));
        });
      });

    }
  }

  void update(){
    ToastLoadingOverlay toastLoadingOverlay = ToastLoadingOverlay(context);
    if(_nameController.text==''||_emailController.text==''||_addressController.text==''||_dobController.text==''){
      ToastOverlay(context).show(type: ToastType.warning,msg: 'Vui lòng điền đầy đủ thông tin');
    }else {
      if(isEmailChecked==true){
        toastLoadingOverlay.show();
        Future.delayed(const Duration(seconds: 2), () async {
          await apiService
              .update(name: _nameController.text,email: _emailController.text,address: _addressController.text,dob: _dobController.text,avtUrl: url??'')
              .then((value) {
            ToastOverlay(context).show(type: ToastType.success, msg: 'Thành công');
            apiService.token = value.token!;
            setState(() {
              name = value.name!;
              phone = value.phoneNumber!;
              email = value.email!;
              dob = value.dateOfBirth!;
              address = value.address!;
              avtUrl = value.avatar;
            });
            print('${value.token}');
            toastLoadingOverlay.hide();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) =>  NewsFeedPage(name: name,phone: phone,avtUrl: url,email: value.email,address: value.address,dob: value.dateOfBirth,)));
          }).catchError((e) {
            toastLoadingOverlay.hide();
            ToastOverlay(context).show(type: ToastType.error, msg: e.toString().replaceAll('Exception: ', ''));
          });

        });
      }else{
        ToastOverlay(context).show(type: ToastType.warning,msg: 'Vui lòng kiểm tra lại các thông tin');
      }

    }
  }



  DateTime textToDate(String dateStr){
    var dateSplit= (dateStr.split('/'));
    int day = int.parse(dateSplit[0]);
    int month = int.parse(dateSplit[1]);
    int year = int.parse(dateSplit[2]);
    return DateTime(year,month,day);
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

}
