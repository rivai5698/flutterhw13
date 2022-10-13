import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ToastLoadingOverlay{
  final BuildContext context;
  OverlayEntry? entry;
  ToastLoadingOverlay(this.context);

  void show(){
    if(entry!=null){
      entry!.remove();
      entry = null;
    }
    entry = OverlayEntry(
        builder: (BuildContext context) {
          return Container(
            color: Colors.white.withOpacity(0.2),
            width: MediaQuery.of(context).size.width,
              child :  Center(
              //child: CircularProgressIndicator(color: Colors.blue,),
                child: LottieBuilder.asset('assets/loading2.json',width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,),
              )
          );
        }

    );
    Overlay.of(context)!.insert(entry!);

  }

  void hide(){
    if(entry!=null){
      entry!.remove();
      entry = null;
    }
  }
}