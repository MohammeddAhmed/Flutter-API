import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vp18_api_app/api/models/process_response.dart';
import 'package:vp18_api_app/get/images_getx_controller.dart';
import 'package:vp18_api_app/utils/context_extension.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Images',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/upload_image_screen'),
            icon: const Icon(Icons.upload_rounded),
            color: Colors.black,
          )
        ],
      ),
      body: GetX<ImagesGetXController>(
        init: ImagesGetXController(),
        builder: (controller) {
          if (controller.loading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.images.isNotEmpty) {
            return GridView.builder(
              itemCount: controller.images.length,
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Image.network(
                        controller.images[index].imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Colors.black45,
                          height: 40,
                          padding: const EdgeInsetsDirectional.only(start: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.images[index].image,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => deleteImage(context, index),
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                "No Images",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void deleteImage(BuildContext context, int index) async {
    ProcessResponse processResponse =
        await ImagesGetXController.to.deleteImage(index);
    context.showSnackBar(
      message: processResponse.message,
      erorr: !processResponse.success,
    );
  }
}
