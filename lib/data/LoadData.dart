import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class LoadData {

  getCityWeather() async {

    var key = "b72db5485a8af53fa7b1e6267df11a60";

    String baseUrl = 'https://api.openweathermap.org/data/2.5/weather?q=Bantul&units=metric&lang=id&appid=$key';

    final response = await http.get(baseUrl);
    debugPrint('TEST_CITY0 : ${response.statusCode}');
    try{
      if (response.statusCode == 200) {
        debugPrint('TEST_CITY1 : ${json.decode(response.body)}');

      } else {

      }
    } on http.ClientException{
      print("throwing new error");
      throw Exception("Error on server");

    }


  }
}