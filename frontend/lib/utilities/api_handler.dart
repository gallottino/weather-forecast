import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHandler {
  static getForecast(String city) async {
    try {
      var url = Uri.parse(
          'http://localhost:3000?city=$city');
      var res = await http.get(url);
      if(res.statusCode == 200) {
        Map<String, dynamic> days = json.decode(res.body);
        return days;
      }

    } catch (e) {
      print(e);
    }
  }
}
