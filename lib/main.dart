import 'package:flutter/material.dart';
import 'package:open_weather/data/LoadData.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Weather(),
    );
  }
}

class Weather extends StatefulWidget {
  const Weather({Key key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String i;

  getCityWeather() async {
    var key = "b72db5485a8af53fa7b1e6267df11a60";

    String baseUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=Bantul&units=metric&lang=id&appid=$key';

    final response = await http.get(baseUrl);
    debugPrint('TEST_CITY0 : ${response.statusCode}');
    try {
      if (response.statusCode == 200) {
        debugPrint('TEST_CITY1 : ${json.decode(response.body)}');

        debugPrint(
            'TEST_CITY2 : ${json.decode(response.body)['weather'][0]['description']}');

        return await json.decode(response.body)['weather'][0]['description'];
      } else {}
    } on http.ClientException {
      print("throwing new error");
      throw Exception("Error on server");
    }
  }

  getData() async {
    i = await getCityWeather();
    return i;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCityWeather();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        child: Center(
            child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData)
              return Text("${snapshot.data}");
            else
              return Text("There is no output yet");
          },
          future: getData(),
        )),
      ),
    );
  }
}
