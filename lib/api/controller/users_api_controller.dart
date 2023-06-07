import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vp18_api_app/api/api_settings.dart';
import 'package:vp18_api_app/api/models/user.dart';

/// API Request :
///  1) Define STRING URI in ApiSettings.dart class.
///  2) Create new Future async function with suitable name.
///  3) Convert STRING URI to URI.
///  4) Define new http request :
///     A) define new request method :
///        1) http.method. ex: import ('package:http/http.dart' as http;).
///     B) Set URI in http.method(uri).
///     C) add Headers if needed.
///     D) add Body if needed.
///  5) Execute request & await Response.
///  6) Detect response results :
///     A) Status Code, U can check if request completed successfully using it.
///       1) SUCCESS: (200, 201, 202).
///       2) FAILED: (400, 401, 403, 405, 500).
///     B) Body (STRING) - encoded :
///       1) Decode response body : Convert STRING response to JSON (Map).

class UsersApiController {
  Future<List<User>> fetchUsers() async {
    Uri uri = Uri.parse(ApiSettings.users);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var dataJsonArray = jsonResponse["data"] as List;
      return dataJsonArray.map((e) => User.fromJson(e)).toList();
    }
    return [];
  }
}
