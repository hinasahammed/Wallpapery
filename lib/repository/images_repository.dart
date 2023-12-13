import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wallpapery/res/app_url.dart';
import 'package:wallpapery/viewModel/images_controller.dart';

final imagesController = Get.put(ImagesController());

class ImagesRepository {
  String baseUrl = AppUrl.baseUrl;

  void fetchData() async {
    imagesController.loading.value = true;
    try {
      await http.get(Uri.parse(baseUrl), headers: {
        'Authorization':
            'GuGr2ZAWUKqP38C6Fwk1sT63Fru2V81XiFP5dSYa9NooksPAoFixYg4W'
      }).then((value) {
        Map result = jsonDecode(value.body);
        imagesController.imagesData.value = result['photos'];
      });
      imagesController.loading.value = false;
    } catch (e) {
      imagesController.loading.value = false;

      Get.snackbar('Error', e.toString());
    }
  }

  void fetchsearchData() async {
    imagesController.loading.value = true;

    try {
      await http.get(
          Uri.parse(
              'https://api.pexels.com/v1/search?query=${imagesController.search.value.text}&per_page=80'),
          headers: {
            'Authorization':
                'GuGr2ZAWUKqP38C6Fwk1sT63Fru2V81XiFP5dSYa9NooksPAoFixYg4W'
          }).then((value) {
        Map result = jsonDecode(value.body);
        imagesController.searchData.value = result['photos'];
      });
      imagesController.loading.value = false;
    } catch (e) {
      imagesController.loading.value = false;

      Get.snackbar('Error', e.toString());
    }
  }

  void fetchFeaturedData() async {
    imagesController.loading.value = true;

    try {
      await http.get(
          Uri.parse(
              'https://api.pexels.com/v1/collections/featured?per_page=40'),
          headers: {
            'Authorization':
                'GuGr2ZAWUKqP38C6Fwk1sT63Fru2V81XiFP5dSYa9NooksPAoFixYg4W'
          }).then((value) {
        Map result = jsonDecode(value.body);
        imagesController.featuredData.value = result['collections'];
        imagesController.loading.value = false;
      });
    } catch (e) {
      imagesController.loading.value = false;

      Get.snackbar('Error', e.toString());
    }
  }

  void fetchFeaturedDataDetails(String id) async {
    imagesController.loading.value = true;

    try {
      await http.get(
          Uri.parse(
              'https://api.pexels.com/v1/collections/$id?per_page=40&sort=desc'),
          headers: {
            'Authorization':
                'GuGr2ZAWUKqP38C6Fwk1sT63Fru2V81XiFP5dSYa9NooksPAoFixYg4W'
          }).then((value) {
        Map result = jsonDecode(value.body);
        imagesController.featuredDataDetails.value = result['media'];
      });
      imagesController.loading.value = false;
    } catch (e) {
      imagesController.loading.value = false;

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
