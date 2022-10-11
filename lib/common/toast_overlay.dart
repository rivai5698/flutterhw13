import 'package:flutter/material.dart';

class ToastOverlay{
  final BuildContext context;
  OverlayEntry? overlayEntry;
  ToastOverlay(this.context);

  void show({ToastType type = ToastType.error, double cnt = 0, String msg = ''}){
    if(overlayEntry!=null){
      overlayEntry!.remove();
      overlayEntry = null;
    }
    overlayEntry = OverlayEntry(builder: (context){
      return Positioned(
        // width: ,
        // height: ,
        top: 60+cnt,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: type == ToastType.success ? Colors.green
                  :type == ToastType.error ? Colors.red
                  :type == ToastType.info ? Colors.white
                  :type == ToastType.warning ? Colors.orange : Colors.red,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black,),

            ),
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Row(
              children: [
                Expanded(child: Text(msg),),
                IconButton(onPressed: (){
                  if(overlayEntry!=null){
                    overlayEntry!.remove();
                  }
                  overlayEntry = null;
                }, icon: const Icon(Icons.close),),
              ],
            ),
          ),
        ),
      );
    });

    if(overlayEntry!=null){
      Overlay.of(context)!.insert(overlayEntry!);
      Future.delayed(const Duration(seconds: 5),(){
        if(overlayEntry!=null){
          overlayEntry!.remove();
          overlayEntry = null;
        }
      });
    }
  }

}

enum ToastType{
  success,
  error,
  warning,
  info,
}