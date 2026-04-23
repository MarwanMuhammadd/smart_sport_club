import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  var key = 'AIzaSyAH2MupU06QvoTnaCwP2ZVMc7Iu6YB9DGA';
  var urls = [
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-lite-preview:generateContent?key=$key',
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$key',
  ];
  
  for (var urlStr in urls) {
    var url = Uri.parse(urlStr);
    var req = await http.post(
      url, 
      headers: {'Content-Type': 'application/json'}, 
      body: jsonEncode({
        'contents': [{'parts': [{'text': 'hello'}]}]
      })
    );
    print('\nModel: ${urlStr.split('/').last.split(':').first}');
    print('Status: ${req.statusCode}');
    if (req.statusCode != 200) print('Error: ${req.body}');
  }
}
