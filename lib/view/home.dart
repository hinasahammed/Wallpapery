import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpapery/repository/images_repository.dart';
import 'package:wallpapery/view/detail.dart';
import 'package:wallpapery/viewModel/images_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    ImagesRepository().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imagesController = Get.put(ImagesController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpapery'),
      ),
      body: Obx(() => Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  itemCount: imagesController.imagesData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: .7,
                  ),
                  itemBuilder: (context, index) {
                    final imageList = imagesController.imagesData[index];
                    return InkWell(
                      onTap: () {
                        Get.to(() =>
                            DetailsView(imageUrl: imageList['src']['large2x']));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            width: Get.width * .25,
                            height: Get.height * .13,
                            imageUrl: imageList['src']['large'],
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.black.withOpacity(0.2),
                              highlightColor: Colors.white54,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    ImagesRepository().loadData();
                  },
                  icon: const Icon(
                    Icons.arrow_circle_down,
                    size: 30,
                  ),
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              )
            ],
          )),
    );
  }
}
