import 'package:get/get.dart';
import 'package:post_mobile_application/core/api/api_service.dart';
import 'package:post_mobile_application/modules/admin/post/controller/post_controller.dart';
import 'package:post_mobile_application/modules/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => PostController(apiService: Get.find<ApiService>()));
  }
}
