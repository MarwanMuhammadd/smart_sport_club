import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  var key = 'AIzaSyAH2MupU06QvoTnaCwP2ZVMc7Iu6YB9DGA';
  var url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models?key=$key');
  var req = await http.get(url);
  
  if (req.statusCode == 200) {
    var data = jsonDecode(req.body);
    for (var model in data['models']) {
      print(model['name']);
    }
  } else {
    print('Failed: ${req.statusCode}');
    print(req.body);
  }
}