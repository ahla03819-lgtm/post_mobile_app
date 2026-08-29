import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:post_mobile_application/core/api/api_service.dart';
import 'package:post_mobile_application/core/models/auth/register/RegisterRequest.dart';
import 'package:post_mobile_application/core/models/auth/register/RegisterResponse.dart';
import 'package:post_mobile_application/modules/auth/register/controller/register_controller.dart';
import 'package:post_mobile_application/routes/app_route_name.dart';

class FakeApiService extends Fake implements ApiService {}

class SuccessfulApiService extends Fake implements ApiService {
  RegisterRequest? request;

  @override
  Future<RegisterResponse> register(RegisterRequest req) async {
    request = req;
    return RegisterResponse(code: '200', message: 'Create Success');
  }
}

void fillValidForm(RegisterController controller) {
  controller.usernameController.value.text = 'john_doe';
  controller.firstNameController.value.text = 'John';
  controller.lastNameController.value.text = 'Doe';
  controller.emailController.value.text = 'john@example.com';
  controller.phoneNumberController.value.text = '0123456789';
  controller.passwordController.value.text = 'Password@123';
  controller.confirmPasswordController.value.text = 'Password@123';
}

void main() {
  tearDown(Get.reset);

  test('serializes the backend register request fields', () {
    final request = RegisterRequest(
      username: 'john_doe',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      phoneNumber: '0123456789',
      password: 'Password@123',
      confirmPassword: 'Password@123',
      role: 'USER',
      profile: '',
    );

    expect(request.toJson(), {
      'username': 'john_doe',
      'firstName': 'John',
      'lastName': 'Doe',
      'email': 'john@example.com',
      'phoneNumber': '0123456789',
      'password': 'Password@123',
      'confirmPassword': 'Password@123',
      'role': 'USER',
      'profile': '',
    });
  });

  test('validates required fields and password confirmation', () {
    final controller = RegisterController(apiService: FakeApiService());

    expect(controller.validate(), 'Please enter your username');
    fillValidForm(controller);
    controller.confirmPasswordController.value.text = 'different';
    expect(controller.validate(), 'Confirm password does not match');
    controller.confirmPasswordController.value.text = 'Password@123';
    expect(controller.validate(), isNull);
  });

  testWidgets('successful registration navigates back to Login', (
    tester,
  ) async {
    Get.testMode = true;
    final apiService = SuccessfulApiService();
    final controller = RegisterController(apiService: apiService);
    fillValidForm(controller);

    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: AppRouteName.register,
        getPages: [
          GetPage(
            name: AppRouteName.register,
            page: () => const Scaffold(body: Text('Register destination')),
          ),
          GetPage(
            name: AppRouteName.login,
            page: () => const Scaffold(body: Text('Login destination')),
          ),
        ],
      ),
    );

    await controller.onRegister();
    await tester.pumpAndSettle();

    expect(find.text('Login destination'), findsOneWidget);
    expect(apiService.request?.role, 'USER');
    expect(apiService.request?.profile, '');

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
