import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_mobile_application/modules/admin/post/controller/post_controller.dart';
import 'package:post_mobile_application/modules/home/controller/home_controller.dart';
import 'package:post_mobile_application/routes/app_route_name.dart';
import 'package:post_mobile_application/widgets/appbar_custom_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final postController = Get.find<PostController>();
    return Obx(
      () => Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.cyan,
          child: ListView(
            children: [
              SizedBox(height: 150),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(AppRouteName.adminDashboard);
                },
                leading: Icon(Icons.dashboard, color: Colors.white),
                title: Text("Dashboard", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppbarCustomWidget(title: "Home"),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: postController.dataLoading.value
              ? Center(child: CircularProgressIndicator(color: Colors.cyan))
              : postController.errorMessage.value.isNotEmpty
              ? Center(child: Text(postController.errorMessage.value))
              : RefreshIndicator(
                  onRefresh: postController.getAllPosts,
                  child: ListView.builder(
                    itemCount: postController.postList.length,
                    itemBuilder: (context, index) {
                      final post = postController.postList[index];
                      return Container(
                        width: double.infinity,
                        color: Colors.black12,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Image.network("${post.image}"),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                "${post.title}",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text("${post.description}"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
