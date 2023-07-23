import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Objects/Quote.dart';

mixin Network_Helper {
  Future<String> getImage(String category) async {
    var response = await http.get(Uri.parse(
        'https://random.imagecdn.app/v1/image?&category=$category&format=json'));
    return jsonDecode(response.body)['url'];
  }

  Future<Quote> getQuote() async {
    var response =
        await http.get(Uri.parse('https://api.quotable.io/quotes/random'));
    return Quote.fromJson(jsonDecode(response.body));
  }
}
