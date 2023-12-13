import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ImagesController extends GetxController {
  RxList imagesData = [].obs;
  RxList searchData = [].obs;
  RxList featuredData = [].obs;
  RxList featuredDataDetails = [].obs;
  RxInt page = 1.obs;
  RxBool loading = false.obs;
  Rx<TextEditingController> search = TextEditingController().obs;

}
