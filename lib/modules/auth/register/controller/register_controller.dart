import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:post_mobile_application/core/api/api_service.dart';
import 'package:post_mobile_application/core/models/auth/register/RegisterRequest.dart';
import 'package:post_mobile_application/routes/app_route_name.dart';

class RegisterController extends GetxController {
  final ApiService apiService;
  RegisterController({required this.apiService});

  var usernameController = TextEditingController().obs;
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneNumberController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var loading = false.obs;

  String? validate() {
    if (usernameController.value.text.trim().isEmpty) {
      return "Please enter your username";
    }
    if (firstNameController.value.text.trim().isEmpty) {
      return "Please enter your first name";
    }
    if (lastNameController.value.text.trim().isEmpty) {
      return "Please enter your last name";
    }
    var email = emailController.value.text.trim();
    if (email.isEmpty) {
      return "Please enter your email";
    }
    if (!GetUtils.isEmail(email)) {
      return "Please enter a valid email";
    }
    if (phoneNumberController.value.text.trim().isEmpty) {
      return "Please enter your phone number";
    }
    if (passwordController.value.text.isEmpty) {
      return "Please enter your password";
    }
    if (confirmPasswordController.value.text.isEmpty) {
      return "Please confirm your password";
    }
    if (passwordController.value.text != confirmPasswordController.value.text) {
      return "Confirm password does not match";
    }
    return null;
  }

  onRegister() async {
    if (loading.value) {
      return;
    }

    var validationMessage = validate();
    if (validationMessage != null) {
      Get.snackbar("Error", validationMessage);
      return;
    }

    loading.value = true;
    try {
      var response = await apiService.register(
        RegisterRequest(
          username: usernameController.value.text.trim(),
          firstName: firstNameController.value.text.trim(),
          lastName: lastNameController.value.text.trim(),
          email: emailController.value.text.trim(),
          phoneNumber: phoneNumberController.value.text.trim(),
          password: passwordController.value.text,
          confirmPassword: confirmPasswordController.value.text,
          role: "USER",
          profile: "",
        ),
      );
      if (response.code == "200") {
        Get.snackbar("Success", response.message ?? "Register Successfully");
        Get.offNamed(AppRouteName.login);
      } else {
        Get.snackbar(
          "Error",
          response.message ?? "Registration failed. Please try again",
        );
      }
    } catch (_) {
      Get.snackbar(
        "Error",
        "Unable to connect to the server. Please try again",
      );
    } finally {
      loading.value = false;
    }
  }
}
