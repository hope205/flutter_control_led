import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String url;

  Future<String> getNoValue(url) async {
    http.Response response = await http.get(url);
  }

  Future<dynamic> getJsonValue(url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = await jsonDecode(data);

      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
