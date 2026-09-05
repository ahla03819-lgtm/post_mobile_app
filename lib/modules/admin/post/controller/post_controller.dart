import 'dart:convert';

import 'package:get/get.dart';
import 'package:post_mobile_application/constants/url_constant.dart';
import 'package:post_mobile_application/core/api/api_service.dart';
import 'package:post_mobile_application/core/models/post/Content.dart';
import 'package:post_mobile_application/core/models/post/PostResponse.dart';

class PostController extends GetxController {
  final ApiService apiService;
  var dataLoading = false.obs;
  var postList = <Content>[].obs;
  var errorMessage = "".obs;

  PostController({required this.apiService});

  Future<void> getAllPosts() async {
    dataLoading.value = true;
    errorMessage.value = "";
    try {
      var response = await apiService.get(
        "${UrlConstants.adminListPostPath}?page=0&size=100&status=ACT",
      );
      if (response == null) {
        errorMessage.value = "Unable to load posts";
        return;
      }
      var responseBody = PostResponse.fromJson(jsonDecode(response));
      postList.value = responseBody.data?.content ?? [];
    } catch (_) {
      errorMessage.value = "Unable to load posts";
    } finally {
      dataLoading.value = false;
    }
  }

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }
}
