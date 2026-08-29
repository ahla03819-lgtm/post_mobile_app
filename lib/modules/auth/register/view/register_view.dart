import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_mobile_application/modules/auth/register/controller/register_controller.dart';
import 'package:post_mobile_application/routes/app_route_name.dart';
import 'package:post_mobile_application/widgets/button_custom_widget.dart';
import 'package:post_mobile_application/widgets/header_title_custom_widget.dart';
import 'package:post_mobile_application/widgets/input_form_custom.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 35, horizontal: 16),
            child: Column(
              children: [
                HeaderTitleCustomWidget(title: "Register"),
                SizedBox(height: 25),
                InputFormCustom(
                  controller: controller.usernameController.value,
                  labelText: "Username",
                  hintText: "Username",
                ),
                InputFormCustom(
                  controller: controller.firstNameController.value,
                  labelText: "First Name",
                  hintText: "First Name",
                ),
                InputFormCustom(
                  controller: controller.lastNameController.value,
                  labelText: "Last Name",
                  hintText: "Last Name",
                ),
                InputFormCustom(
                  controller: controller.emailController.value,
                  labelText: "Email",
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                InputFormCustom(
                  controller: controller.phoneNumberController.value,
                  labelText: "Phone Number",
                  hintText: "Phone Number",
                  keyboardType: TextInputType.phone,
                ),
                InputFormCustom(
                  controller: controller.passwordController.value,
                  labelText: "Password",
                  hintText: "Password",
                  obscureText: true,
                ),
                InputFormCustom(
                  controller: controller.confirmPasswordController.value,
                  labelText: "Confirm Password",
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                SizedBox(height: 25),
                ButtonCustomWidget(
                  onClick: controller.loading.value
                      ? null
                      : () {
                          controller.onRegister();
                        },
                  loading: controller.loading.value,
                  title: "Register",
                ),
                TextButton(
                  onPressed: controller.loading.value
                      ? null
                      : () => Get.offNamed(AppRouteName.login),
                  child: Text("Back to Login"),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
