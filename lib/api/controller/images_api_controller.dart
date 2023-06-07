import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vp18_api_app/api/api_helper.dart';
import 'package:vp18_api_app/api/api_settings.dart';
import 'package:vp18_api_app/api/models/process_response.dart';
import 'package:vp18_api_app/api/models/student_image.dart';
import 'package:vp18_api_app/prefs/shared_pref_controller.dart';

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

class ImagesApiController with ApiHelper {

  Future<List<StudentImage>> fetchImages() async {
    Uri uri = Uri.parse(ApiSettings.image.replaceFirst("/{id}", ""));
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse["data"] as List;
      return jsonArray.map((e) => StudentImage.fromJson(e)).toList();
    }
    return [];
  }

  Future<ProcessResponse> deleteImage(int id) async {
    Uri uri = Uri.parse(ApiSettings.image.replaceFirst("{id}", id.toString()));
    var response = await http.delete(uri, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ProcessResponse(jsonResponse["message"], jsonResponse["status"]);
    }
    return errorResponse;
  }

  Future<ProcessResponse<StudentImage>> uploadImage(String path) async {
    Uri uri = Uri.parse(ApiSettings.image.replaceFirst("/{id}", ""));
    var request = http.MultipartRequest("POST", uri);
    var file = await http.MultipartFile.fromPath("image", path);
    request.files.add(file);
    // request.fields["email"] = "value";
    // request.fields["password"] = "value";
    request.headers[HttpHeaders.acceptHeader] = "application/json";
    request.headers[HttpHeaders.authorizationHeader] =
        SharedPrefController().getValue<String>(PrefKeys.token.name)!;
    var response = await request.send();
    if (response.statusCode == 201 || response.statusCode == 400) {
      var body = await response.stream.transform(utf8.decoder).first;
      var jsonResponse = jsonDecode(body);
      var processResponse = ProcessResponse<StudentImage>(
          jsonResponse["message"], jsonResponse["success"]);
      if (response.statusCode == 201) {
        var jsonObject = jsonResponse["object"];
        StudentImage studentImage = StudentImage.fromJson(jsonObject);
        processResponse.object = studentImage;
      }
      return processResponse;
    }
    return genericErrorResponse<StudentImage>();
  }
}
