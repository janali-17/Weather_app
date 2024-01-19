import 'package:flutter/material.dart';
import 'package:weather_app/Worker/Worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  dynamic temp;
  dynamic hum;
  dynamic air_speed;
  dynamic des;
  dynamic main;
  dynamic icon;
  dynamic city = "Islamabad";

  void startApp(dynamic city) async {
    worker instance = worker(location: city);
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    icon = instance.icon;

    Future.delayed(Duration(seconds: 5));
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      "temp_value": temp,
      "hum_value": hum,
      "air_speed_value": air_speed,
      "des_value": des,
      "main_value": main,
      "icon_value": icon,
      "city_value" : city,
    });
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)?.settings.arguments as Map?;
    if(search?.isNotEmpty ?? false)
      {
        city = search?['searchText'];
      }
    startApp(city);

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              child: Image.asset(
            "images/logo6.png",
            height: 250,
            width: 250,
          )),
          SizedBox(
            height: 20,
          ),
          Text(
            "Weather App",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text("Made By Sam",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              )),
          SizedBox(height: 40),
          SpinKitWave(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.white : Colors.white,
                ),
              );
            },
          ),
        ],
      )),
      backgroundColor: Colors.blueAccent[200],
    );
  }
}
