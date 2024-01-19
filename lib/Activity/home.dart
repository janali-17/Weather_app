import 'dart:convert';
import 'dart:math';
import 'package:weather_app/Activity/loading.dart';
import 'package:weather_app/Worker/Worker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:characters/characters.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var city_name = ["Islamabad", "Lahore", "Karachi", "Peshawar", "Quetta"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];

    final Map<String, dynamic>? info =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    dynamic air = ((info?['air_speed_value']).toString());
    dynamic temp = ((info?['temp_value']).toString());
    if (temp == "NA") {
      print("NA");
    } else {
      air = ((info?['air_speed_value']).toString()).substring(0, 4);
      temp = ((info?['temp_value']).toString()).substring(0, 4);
    }
    dynamic icon = info?['icon_value'];
    dynamic getcity = info?['city_value'];
    dynamic hum = info?['hum_value'];
    dynamic des = info?['des_value'];

    // final Map<String, dynamic>? info =
    // ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    // Map info= ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: GradientAppBar(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.3,
                0.5
              ],
              colors: [
                Colors.blueAccent,
                Colors.blue,
              ]),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                0.4,
                0.6
              ],
                  colors: [
                Colors.blueAccent,
                Colors.blue,
              ])),
          child: Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: 900,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      margin:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(24)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if ((searchController.text).replaceAll(" ", "") ==
                                  "") {
                                print("Blank");
                              } else {
                                Navigator.pushReplacementNamed(
                                    context, "/loading",
                                    arguments: {
                                      "searchText": searchController.text,
                                    });
                              }
                            },
                            child: Container(
                              child: Icon(Icons.search),
                              margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search $city",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Image.network(
                                    "https://openweathermap.org/img/wn/$icon@2x.png"),
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "$des",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "In $getcity",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            padding: EdgeInsets.all(28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.thermometer),
                                SizedBox(
                                  height: 35,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "$temp",
                                      style: TextStyle(
                                        fontSize: 100,
                                      ),
                                    ),
                                    Text("C",
                                        style: TextStyle(
                                          fontSize: 50,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5),
                            ),
                            margin: EdgeInsets.fromLTRB(25, 0, 10, 0),
                            padding: EdgeInsets.all(28),
                            height: 200,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(WeatherIcons.day_windy),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "$air",
                                  style: TextStyle(
                                    fontSize: 55,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("km/hr")
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5),
                            ),
                            margin: EdgeInsets.fromLTRB(10, 0, 25, 0),
                            padding: EdgeInsets.all(28),
                            height: 200,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(WeatherIcons.humidity),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "$hum",
                                  style: TextStyle(
                                    fontSize: 55,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Percent",
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(65),
                        child: Column(
                          children: [
                            Text(
                              "Made By Sam",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Data Provide by Openweathermap.org",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Column(children: <Widget>[
// ElevatedButton.icon(onPressed: (){
// Navigator.pushNamed(context, "/home",);
// },
// icon: Icon(Icons.add_to_home_screen)
