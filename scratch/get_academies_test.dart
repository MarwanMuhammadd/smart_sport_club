import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  try {
    print("Fetching academies...");
    final response = await http.get(
      Uri.parse("https://e-club.runasp.net/api/academies/screen"),
    );
    print("Status code: ${response.statusCode}");
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print("Response type: ${decoded.runtimeType}");
      if (decoded is List) {
        print("Total academies: ${decoded.length}");
        for (var item in decoded.take(5)) {
          print("Academy: ${item['id']} - Name: ${item['name']} - Type: ${item['type']} - SportId: ${item['sportId']} - Location: ${item['location']}");
        }
      } else if (decoded is Map) {
        print("Keys: ${decoded.keys}");
        final all = decoded['all'];
        if (all is List) {
          print("Total academies in 'all': ${all.length}");
          for (var item in all) {
            print("Academy: ${item['id']} - Name: ${item['name']} - Type: ${item['type']} - SportId: ${item['sportId']} - Location: ${item['location']}");
          }
        }
      }
    } else {
      print("Error: ${response.body}");
    }
  } catch (e) {
    print("General Error: $e");
  }
}
