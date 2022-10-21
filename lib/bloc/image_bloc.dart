import 'dart:async';

class ImageBloc{
  final _imgController = StreamController<int>();

  Stream<int> get stream => _imgController.stream;

  StreamSink<int> get sink => _imgController.sink;


  int index = 0;

  Future<void> closeStream() => _imgController.close();

  bool isClosed(){
    return _imgController.isClosed;
  }

  Future<void> getIndex(int i) async{
    await Future.delayed(Duration.zero);
    _imgController.add(index = i);
  }

}