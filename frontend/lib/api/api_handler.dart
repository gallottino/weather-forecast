import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHandler {
  static getForecast(double latitude, double longitude) async {
    try {
      var url = Uri.parse(
          'http://localhost:3000?lat=45.0703&lon=7.6869&units=metric');
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
