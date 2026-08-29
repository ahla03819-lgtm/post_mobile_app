import 'package:flutter_test/flutter_test.dart';
import 'package:post_mobile_application/core/api/api_service.dart';
import 'package:post_mobile_application/core/models/auth/register/RegisterRequest.dart';
import 'package:post_mobile_application/core/models/auth/register/RegisterResponse.dart';
import 'package:post_mobile_application/modules/auth/register/controller/register_controller.dart';

class FakeApiService extends Fake implements ApiService {}

void main() {
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

  test('parses a successful backend register response', () {
    final response = RegisterResponse.fromJson({
      'message': 'Create Success',
      'messageKh': 'success-kh',
      'messageCh': 'Create Success',
      'code': '200',
      'data': 'User Open Account successfully!',
    });

    expect(response.code, '200');
    expect(response.message, 'Create Success');
    expect(response.data, 'User Open Account successfully!');
  });

  test('validates required fields and password confirmation', () {
    final controller = RegisterController(apiService: FakeApiService());

    expect(controller.validate(), 'Please enter your username');

    controller.usernameController.value.text = 'john_doe';
    controller.firstNameController.value.text = 'John';
    controller.lastNameController.value.text = 'Doe';
    controller.emailController.value.text = 'john@example.com';
    controller.phoneNumberController.value.text = '0123456789';
    controller.passwordController.value.text = 'Password@123';
    controller.confirmPasswordController.value.text = 'different';

    expect(controller.validate(), 'Confirm password does not match');

    controller.confirmPasswordController.value.text = 'Password@123';
    expect(controller.validate(), isNull);
  });
}
