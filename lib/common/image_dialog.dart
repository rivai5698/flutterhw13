
import 'package:flutter/material.dart';

import 'const.dart';

class ImageDialog {
  final BuildContext context;

  ImageDialog(this.context);

  void showImageDialog(String imgUrl) {
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
              child: _imageExpand(imgUrl),
            ),
          );
        });
  }

  Widget _imageExpand(String imgUrl) {
    String imageUrl = imgUrl;
    if (!imageUrl.startsWith('http')) {
      imageUrl = baseUrl + imageUrl;
      if(imageUrl.contains('comuploads')){
        imageUrl = imageUrl.replaceAll('comuploads', 'com/uploads');
      }
    }
    return Container(
      color: Colors.white.withOpacity(0.8),
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(imageUrl, fit: BoxFit.contain,
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
          Positioned(
            right: 0,
              child:
              SafeArea(
                child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
              ),
          )
        ],
      )
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Align(
      //       alignment: Alignment.topLeft,
      //       child: IconButton(
      //         onPressed: () {
      //           Navigator.pop(context);
      //         },
      //         icon: const Icon(
      //           Icons.close_rounded,
      //           color: Colors.black,
      //           size: 32,
      //         ),
      //       ),
      //     ),
      //     Center(
      //       child: Image.network(
      //         imgUrl,
      //         width: double.infinity,
      //       ),
      //     ),


      //  ],
      //),
    );
  }
}
