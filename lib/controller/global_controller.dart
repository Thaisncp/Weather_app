import 'package:get/get.dart';

class GlobalController extends GetxController{
  final RxInt _currentIndex = 0.obs;

  @override
  void onInit() {
    getIndex();
  }

  RxInt getIndex() {
    return _currentIndex;
  }
}