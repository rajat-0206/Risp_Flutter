import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class askRisp {
  Future<String> question(String query) async {
    String url = "https://chatbot.pythonanywhere.com/askrisp/?query=" + query;

    final response = await http.get(url);
    final data = json.decode(response.body);
    return data;
  }
}
