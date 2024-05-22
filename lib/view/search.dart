import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpapery/repository/images_repository.dart';
import 'package:wallpapery/view/detail.dart';
import 'package:wallpapery/viewModel/images_controller.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final controller = Get.put(ImagesController());

  @override
  void dispose() {
    super.dispose();
    controller.search.value.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Column(
            children: [
              TextField(
                controller: controller.search.value,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  if (imagesController.search.value.text.isNotEmpty) {
                    ImagesRepository().fetchsearchData();
                  }
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (imagesController.search.value.text.isNotEmpty) {
                        ImagesRepository().fetchsearchData();
                      }
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
              const Gap(20),
              imagesController.loading.value == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: theme.colorScheme.onSurface,
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        itemCount: imagesController.searchData.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: .7,
                        ),
                        itemBuilder: (context, index) {
                          var imageList = imagesController.searchData[index];
                          if (imagesController.searchData[0].isEmpty) {
                            return Center(
                              child: Text(
                                'Enter the text',
                                style: theme.textTheme.titleLarge!.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                Get.to(() => DetailsView(
                                    imageUrl: imageList['src']['large2x']));
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
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.black.withOpacity(0.2),
                                      highlightColor: Colors.white54,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                          }
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
