import 'package:flutter_test/flutter_test.dart';
import 'package:post_mobile_application/routes/app_route_name.dart';
import 'package:post_mobile_application/routes/app_routes.dart';

void main() {
  test('registers the teacher application routes', () {
    final routeNames = AppRoutes.getAllRoutes().map((route) => route.name);

    expect(routeNames, [
      AppRouteName.splash,
      AppRouteName.home,
      AppRouteName.login,
      AppRouteName.register,
      AppRouteName.adminDashboard,
      AppRouteName.adminPost,
    ]);
  });
}
