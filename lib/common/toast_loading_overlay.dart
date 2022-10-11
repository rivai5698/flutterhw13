import 'package:flutter/material.dart';

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
            color: Colors.grey.withOpacity(0.2),
            width: MediaQuery.of(context).size.width,
              child : const Center(
              child: CircularProgressIndicator(color: Colors.blue,),
              )
          );
        }

    );

    if(entry!=null){
      Overlay.of(context)!.insert(entry!);
      Future.delayed(const Duration(seconds: 2),(){
        if(entry!=null){
          entry!.remove();
          entry = null;
        }
      });
    }
  }
}