import 'dart:async';

import 'package:flutter/material.dart';
import '../bloc/image_bloc.dart';
import 'const.dart';

class GroupImageDialog {
  final BuildContext context;
  ImageBloc imageBloc;
  late StreamSubscription subscription;

  GroupImageDialog(this.context, this.imageBloc);
  void showGroupImageDialog(List<String> listImg, int index) {
    // subscription = imageBloc.stream.listen((event) {
    //
    // });
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.grey.withOpacity(0.2),
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder: (_, __, ___) {
          return Container(
            color: Colors.grey.withOpacity(0.2),
            alignment: Alignment.center,
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    top: 50,
                    bottom: 50,
                    child: StreamBuilder<int>(
                      stream: imageBloc.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error'),
                          );
                        }
                        if (snapshot.hasData) {
                          return _itemImg(listImg, snapshot.data!);
                        }
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                                child: CircularProgressIndicator()));
                      },
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: SafeArea(
                      child: IconButton(
                        onPressed: () {
                          imageBloc.closeStream();
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }


  Widget _itemImg(List<String> imgUrl, int index) {
    String imageUrl = imgUrl[index];
    if (!imageUrl.startsWith('http')) {
      imageUrl = baseUrl + imageUrl;
    }
    return Container(
      color: Colors.white.withOpacity(0.8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onPanUpdate: (details) {
                // Swiping in right direction.
                if (details.delta.dx > 0) {
                  if (index >= 1) {
                    index = index - 1;
                  } else {
                    index = index;
                  }
                  imageBloc.getIndex(index);

                }

                // Swiping in left direction.
                if (details.delta.dx < 0) {

                  if (index < imgUrl.length - 1) {
                    index = index + 1;
                  } else {
                    index = index;
                  }
                  imageBloc.getIndex(index);
                }
              },
              child: Image.network(imageUrl,fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) {
                return const Icon(
                  Icons.error,
                  color: Colors.redAccent,
                  size: 25,
                );
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
          ),
          Positioned(
              top: 50,
              bottom: 50,
              right: 0,
              child: IconButton(
                  onPressed: () {
                    if (index < imgUrl.length - 1) {
                      index = index + 1;
                    } else {
                      index = index;
                    }
                    imageBloc.getIndex(index);
                  },
                  icon: const Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                    size: 32,
                  ))),
          Positioned(
              top: 50,
              bottom: 50,
              left: 0,
              child: IconButton(
                  onPressed: () {
                    if (index >= 1) {
                      index = index - 1;
                    } else {
                      index = index;
                    }
                    imageBloc.getIndex(index);
                  },
                  icon: const Icon(
                    Icons.navigate_before,
                    color: Colors.black,
                    size: 32,
                  ))),
        ],
      ),
    );
  }
}
