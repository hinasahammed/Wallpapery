import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpapery/repository/images_repository.dart';
import 'package:wallpapery/view/detail.dart';
import 'package:wallpapery/viewModel/images_controller.dart';

class EachCollection extends StatefulWidget {
  final String id;
  final String title;
  const EachCollection({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  State<EachCollection> createState() => _EachCollectionState();
}

class _EachCollectionState extends State<EachCollection> {
  @override
  void initState() {
    super.initState();
    ImagesRepository().fetchFeaturedDataDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imagesController = Get.put(ImagesController());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Obx(() => Column(
            mainAxisAlignment: imagesController.loading.value == true
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              imagesController.loading.value == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: theme.colorScheme.onBackground,
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        itemCount: imagesController.featuredDataDetails.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: .7,
                        ),
                        itemBuilder: (context, index) {
                          final data =
                              imagesController.featuredDataDetails[index];
                          if (imagesController.featuredDataDetails.isEmpty) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return InkWell(
                              onTap: () {
                                Get.to(
                                  () => DetailsView(
                                    imageUrl: data['src']['large'],
                                  ),
                                );
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
                                    imageUrl: data['src']?['medium'] ??
                                        'https://i.pinimg.com/564x/60/4f/c7/604fc7ac1a35548f288fabea8bbf8e97.jpg',
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
          )),
    );
  }
}
