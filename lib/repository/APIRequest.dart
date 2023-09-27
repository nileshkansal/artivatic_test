import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class APIRequest {

  String TAG = "APIRequest";
  final ResponseListener listener;

  APIRequest({required this.listener});

  Future<void> getResponse() async {
    final url = Uri.parse('https://run.mocky.io/v3/c4ab4c1c-9a55-4174-9ed2-cbbe0738eedf');
    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);
      debugPrint("$TAG response statusCode ==========> ${response.statusCode}");
      debugPrint("$TAG response body ==========> ${response.body}");

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        if (decodedResponse != null && decodedResponse != "") {
          listener.onSuccess(decodedResponse);
        } else {
          listener.onFailed({'error': 'failed to load response'});
        }
      } else {
        listener.onFailed({'error': 'HTTP ${response.statusCode}'});
      }
    } catch (e) {
      listener.onFailed({'error': 'An error occurred: $e'});
    }
  }
}

abstract class ResponseListener {
  void onSuccess(Map<String, dynamic> response);
  void onFailed(Map<String, dynamic> response);
}