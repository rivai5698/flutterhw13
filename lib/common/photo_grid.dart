import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterhw13/common/const.dart';

class PhotoGrid extends StatefulWidget {
  final int maxImages;
  final List<String> imageUrls;
  final Function(int) onImageClicked;
  final Function(int) onExpandClicked;

  const PhotoGrid({super.key,
    required this.imageUrls,
    required this.onImageClicked,
    required this.onExpandClicked,
    this.maxImages = 4,
    //required Key key
  });

  @override
  createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    var images = buildImages();
    if(widget.imageUrls.length==1){
      return buildOneImages();
    }else{
      return GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        children: images,
      );
    }
  }

  buildOneImages(){
    String imageUrl = widget.imageUrls[0];
    if (!imageUrl.startsWith('http')) {
      imageUrl = baseUrl + imageUrl;
    }
    return GestureDetector(
      child: Image.network(imageUrl, fit: BoxFit.fill,
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
      onTap: () => widget.onImageClicked(0),
    );
  }

  List<Widget> buildImages() {
    int numImages = widget.imageUrls.length;
      return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
        String imageUrl = widget.imageUrls[index];
        if (!imageUrl.startsWith('http')) {
          imageUrl = baseUrl + imageUrl;
        }
        // If its the last image
        if (index == widget.maxImages - 1) {
          // Check how many more images are left
          int remaining = numImages - widget.maxImages;

          // If no more are remaining return a simple image widget
          if (remaining == 0) {
            return GestureDetector(
              child: Image.network(imageUrl, fit: BoxFit.cover,
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
              onTap: () => widget.onImageClicked(index),
            );
          } else {
            return GestureDetector(
              onTap: () => widget.onExpandClicked(index),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(imageUrl, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return const Icon(Icons.error,color: Colors.redAccent,size: 25);
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
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.black54,
                      child: Text(
                        '+$remaining',
                        style: const TextStyle(fontSize: 32,color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return GestureDetector(
            child: Image.network(imageUrl, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Icon(Icons.error,color: Colors.redAccent,size: 25);
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
            onTap: () => widget.onImageClicked(index),
          );
        }
      });



  }
}
