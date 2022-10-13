import 'package:flutter/material.dart';
import 'package:flutterhw13/common/my_button.dart';
import 'package:flutterhw13/common/my_text_field.dart';
import 'package:flutterhw13/model/issue_service.dart';
import 'package:flutterhw13/pages/news_feed_page.dart';
import 'package:flutterhw13/services/photo_service.dart';
import 'package:image_picker/image_picker.dart';

import '../common/const.dart';
import '../common/toast_loading_overlay.dart';
import '../common/toast_overlay.dart';
import '../services/api_service.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  final ImagePicker _picker = ImagePicker();
  List<String> listPic=[];
  String listPhotos='';
  String? imgUrl;
  @override
  void initState() {
    // TODO: implement initState
    _contentController = TextEditingController();
    _titleController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var heightM = MediaQuery.of(context).size.height;
    var widthM = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: widthM,
          height: heightM,
          margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              MyTextField(
                text: 'Tiêu đề',
                textEditingController: _titleController,
                autofocus: true,
                inputCheck: '',
              ),
              const SizedBox(
                height: 16,
              ),
              MyTextField(
                text: 'Nội dung',
                minLines: 3,
                maxLines: 5,
                textEditingController: _contentController,
                inputCheck: '',
              ),
              const SizedBox(
                height: 16,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: listPic.length+1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0.5,
                  mainAxisSpacing: 0.5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if(listPic.isNotEmpty){
                    if (index == listPic.length) {
                      return _addImageWidget();
                    } else {
                      return _imageWidget(listPic[index]);
                    }
                  }else{
                    return _addImageWidget();
                  }

                },
              ),
              const SizedBox(
                width: 32,
              ),
              MyButton(
                text: 'Lưu',
                isEnable: true,
                onPressed: () {
                  postIssue();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  void postIssue() {
    ToastLoadingOverlay toastLoadingOverlay = ToastLoadingOverlay(context);
    if(_titleController.text!=''&&_contentController.text!=''){
      toastLoadingOverlay.show();
      Future.delayed(const Duration(seconds: 2),(){
        apiService.postIssue(title: _titleController.text,content: _contentController.text,photo: listPhotos).then((value){
          toastLoadingOverlay.hide();
          ToastOverlay(context).show(msg:'Thành công',type:ToastType.success);
          setState(() {
            _contentController.text='';
            _titleController.text='';
            listPic=[];
            listPhotos='';
          });
        }).catchError((e){
          toastLoadingOverlay.hide();
          ToastOverlay(context).show(type: ToastType.error, msg: e.toString().replaceAll('Exception: ', ''));
        });
      });
    }else{
      ToastOverlay(context).show(msg: 'Vui lòng điền đầy đủ thông tin',type: ToastType.warning);
    }
  }

  Future selImage({required ImageSource source}) async{
    try{
      final img = await _picker.pickImage(source: source);

      if(img!=null){
        uploadImg(img);
      }
    }catch(e){
      // getLostData();
      ToastOverlay(context).show(msg: 'Error: $e');
      //print('$e');
    }


  }

  void uploadImg(XFile file){
    ToastLoadingOverlay toastLoadingOverlay = ToastLoadingOverlay(context);
    if(file!=null){
      toastLoadingOverlay.show();
      Future.delayed(const Duration(seconds: 2),() async {
        await apiService.uploadImg(file: file).then((value){
          ToastOverlay(context).show(msg: 'Upload ảnh thành công',type: ToastType.success);

          print(value.path);
          setState(() {
            imgUrl = '$baseUrl${value.path}';
            listPic.add('$baseUrl${value.path}');

            listPhotos = '';
            for(String str in listPic){
              listPhotos = '$listPhotos$str|';
            }
            listPhotos = listPhotos.substring(0,listPhotos.length-1);
            print(listPhotos);
            print(listPic);
          });
          toastLoadingOverlay.hide();
        }).catchError((e){
          toastLoadingOverlay.hide();
          ToastOverlay(context).show(msg: e.toString().replaceAll('Exception: ', ''));
        });
      });

    }
  }

  Widget _imageWidget(String imgUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Image.network(
        imgUrl,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width / 4,
        height: 80,
      ),
    );
  }

  Widget _addImageWidget() {
    return Container(
      //width: MediaQuery.of(context).size.width/4,
      //height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey),
      ),
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () {
          selImage(source: ImageSource.gallery);
        },
        icon: const Icon(Icons.broken_image_outlined),
      ),
    );
  }



}
