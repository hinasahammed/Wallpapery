import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpapery/repository/images_repository.dart';
import 'package:wallpapery/view/each_collection.dart';
import 'package:wallpapery/viewModel/images_controller.dart';

class CollectionView extends StatefulWidget {
  const CollectionView({super.key});

  @override
  State<CollectionView> createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
  @override
  void initState() {
    super.initState();
    ImagesRepository().fetchData();
    ImagesRepository().fetchFeaturedData();
  }

  @override
  Widget build(BuildContext context) {
    final imagesController = Get.put(ImagesController());
    return Scaffold(
      body: Obx(() => Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  itemCount: imagesController.featuredData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    final data = imagesController.featuredData[index];
                    return InkWell(
                      onTap: () {
                        Get.to(() => EachCollection(
                              id: data['id'],
                              title: data['title'],
                            ));
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(data['title']),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
