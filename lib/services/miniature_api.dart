import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newflutterapp/models/user.dart';

class MiniatureApiService {
  static String baseUri = 'https://miniature.shiipou.fr/api';

  static Future<User> login(String username, String password) async {
    Map<String, dynamic> response = await http
        .post(
      Uri.parse('$baseUri/auth/login'),
      headers: headers(),
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    )
        .then((response) {
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(response.reasonPhrase);
      }
    });
    final tokenInfo = decodeJwt(response['accessToken']);
    User user =
        User(username: tokenInfo['payload']['sub'], token: tokenInfo['token']);
    return user;
  }

  static Map<String, String> headers(
      {String? token, Map<String, String>? additionnalHeaders}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers = {
        ...headers,
        'Authorization': 'Bearer $token',
      };
    }
    if (additionnalHeaders != null) {
      headers = {
        ...headers,
        ...additionnalHeaders,
      };
    }
    return headers;
  }

  static Map<String, dynamic> decodeJwt(String token) {
    final parts = token.split(".");
    if (parts.length != 3) {
      throw Exception('Invalid JWT Token');
    }

    final header = jsonDecode(utf8.decode(base64Decode(parts[0])));
    final payload = jsonDecode(utf8.decode(base64Decode(parts[1])));

    return {
      'header': header,
      'payload': payload,
      'token': token,
    };
  }
}
