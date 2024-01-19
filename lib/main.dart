import 'dart:js';

import 'package:flutter/material.dart';
import 'package:weather_app/Activity/home.dart';
import 'package:weather_app/Activity/loading.dart';
import 'package:weather_app/Activity/location.dart';
import 'package:http/http.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
     "/" : (context) => Loading(),
     "/home":(context) => Home(),
      "/loading" : (context) => Loading(),
    },
  ));
}

