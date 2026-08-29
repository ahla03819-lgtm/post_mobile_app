class UrlConstants {
  UrlConstants._();
  static const String baseUrl = "http://10.0.2.2:30033";
  static const String loginPath = "$baseUrl/api/oauth/token";
  static const String registerPath = "$baseUrl/api/oauth/register";
  static const String refreshTokenPath = "$baseUrl/api/oauth/refresh";
  static const String adminListPostPath = "$baseUrl/api/app/post";
}
