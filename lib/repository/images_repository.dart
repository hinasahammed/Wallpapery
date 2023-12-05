import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wallpapery/res/app_url.dart';
import 'package:wallpapery/viewModel/images_controller.dart';

final imagesController = Get.put(ImagesController());

class ImagesRepository {
  String baseUrl = AppUrl.baseUrl;

  void fetchData() async {
    try {
      await http.get(Uri.parse(baseUrl), headers: {
        'Authorization':
            'GuGr2ZAWUKqP38C6Fwk1sT63Fru2V81XiFP5dSYa9NooksPAoFixYg4W'
      }).then((value) {
        Map result = jsonDecode(value.body);

        imagesController.imagesData.value = result['photos'];
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void loadData() async {
    imagesController.page.value++;
    try {
      await http.get(Uri.parse('$baseUrl&page=${imagesController.page.value}'),
          headers: {
            'Authorization':
                'GuGr2ZAWUKqP38C6Fwk1sT63Fru2V81XiFP5dSYa9NooksPAoFixYg4W'
          }).then((value) {
        Map result = jsonDecode(value.body);
        imagesController.imagesData.addAll(result['photos']);
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
