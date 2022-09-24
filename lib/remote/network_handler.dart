import 'package:flutter/foundation.dart';
import 'package:flutter_exercise/resources/api_managers.dart';
import 'package:http/http.dart' as http;
import 'exceptionHandlers.dart';


class NetworkHandler {
  static final client = http.Client();


  Future get(endpoint) async {
    try {
      http.Response response =
      (await client.get(
          buildUrl(endpoint)));
      return response.body;
    }catch(e){
      throw ExceptionHandlers().getExceptionString(e);
    }
  }


  static Uri buildUrl(String url) {
    final api_path = AppApis.baseApiUrl + url;
    if (kDebugMode) {
      print(api_path);
    }
    return Uri.parse(api_path);
  }

}
