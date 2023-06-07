import 'package:get/get.dart';
import 'package:vp18_api_app/api/controller/images_api_controller.dart';
import 'package:vp18_api_app/api/models/process_response.dart';
import 'package:vp18_api_app/api/models/student_image.dart';

class ImagesGetXController extends GetxController {

  static ImagesGetXController get to => Get.find();
  RxList<StudentImage> images = <StudentImage>[].obs;
  RxBool loading = false.obs;
  final ImagesApiController apiController = ImagesApiController();

  @override
  void onInit() {
    read();
    super.onInit();
  }

  void read() async {
    loading.value = true;
    images.value = await apiController.fetchImages();
    loading.value = false;
  }

  Future<ProcessResponse> uploadImage(String path) async {
    ProcessResponse<StudentImage> processResponse =
        await apiController.uploadImage(path);
    if (processResponse.success) {
      images.add(processResponse.object);
    }
    return processResponse;
  }

  Future<ProcessResponse> deleteImage(int index) async {
    ProcessResponse processResponse =
        await apiController.deleteImage(images[index].id);
    if (processResponse.success) {
      images.removeAt(index);
    }
    return processResponse;
  }
}
