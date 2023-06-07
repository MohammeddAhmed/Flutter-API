class ApiSettings {
  static const String _baseUrl = "https://demo-api.mr-dev.tech/api/";

  static const String users = "${_baseUrl}users";
  static const String login = "${_baseUrl}students/auth/login";
  static const String register = "${_baseUrl}students/auth/register";
  static const String logout = "${_baseUrl}students/auth/logout";

  static const String image = "${_baseUrl}student/images/{id}";
}
