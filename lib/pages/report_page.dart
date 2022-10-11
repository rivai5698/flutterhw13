import 'package:flutter/material.dart';
import 'package:flutterhw13/common/my_button.dart';
import 'package:flutterhw13/common/my_text_field.dart';
import 'package:flutterhw13/pages/news_feed_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}
class _ReportPageState extends State<ReportPage> {
  late TextEditingController _textEditingController;
  @override
  void initState() {
    // TODO: implement initState
    _textEditingController = TextEditingController();
    super.initState();
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
          margin: const EdgeInsets.symmetric(vertical: 24,horizontal: 32),
          child: Column(
            children: [
               MyTextField(text: 'Tiêu đề', textEditingController: _textEditingController,),
              const SizedBox(height: 16,),
               MyTextField(text: 'Nội dung',minLines: 3,maxLines: 5, textEditingController: _textEditingController,),
              const SizedBox(height: 16,),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 2,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0.5,
                  mainAxisSpacing: 0.5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if(index==1){
                    return _addImageWidget();
                  }else{
                    return _imageWidget();
                  }

                },
              ),
              const SizedBox(width: 32,),
              MyButton(text: 'Lưu', onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const NewsFeedPage()));
              },),
            ],
          ),
        ),
      ),
    );
  }
  Widget _imageWidget(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Image.asset('assets/logo.png',
      fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width/4,
        height: 80,
      ),
    );
  }

  Widget _addImageWidget(){
    return Container(
      //width: MediaQuery.of(context).size.width/4,
      //height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey),
      ),
      alignment: Alignment.center,
      child: IconButton(
        onPressed: (){},
        icon: const Icon(Icons.broken_image_outlined),
      ),
    );
  }

}
