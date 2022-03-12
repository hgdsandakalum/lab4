import 'dart:convert';

import 'package:http/http.dart';

class AgifyService {
  static const String endpoint = "https://api.agify.io";

  const AgifyService();

  Future<int?> getAgeFromName(String name) async {
    Response res = await get(
      Uri.parse(endpoint).replace(
        queryParameters: {
          "name": name,
        },
      ),
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body)['age'];
    }
    throw Exception("Error in getting the age!");
  }
}
