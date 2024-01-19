import 'package:http/http.dart';
import 'dart:convert';
class worker
{
  dynamic location = "";
  worker({this.location})
  {
    location = this.location;
  }

  dynamic air_speed = "";
  dynamic description = "";
  dynamic temp= "";
  dynamic humidity= "";
  dynamic main = "";
  dynamic icon = "";

  Future<void> getData() async
  {
    try {
      Response response = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=a6f4c0f9bfe432370bca917a5ddc162f"));
      Map data = jsonDecode(response.body);

      // Temp, Humidity
      Map temp_data = data['main'];
      double getHumidity = temp_data['humidity'];
      double getTemp = temp_data['temp'] - 273.15;

      // Air_speed
      Map wind = data['wind'];
      double getAir_speed = wind['speed'] / 0.27777777777778;

      // Description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      dynamic getMain_des = weather_main_data['main'];
      dynamic getDesc = weather_main_data['description'];
      icon = weather_main_data['icon'].toString();

      //assigning values
      temp = getTemp.toString();      // C
      humidity = getHumidity.toString();    // %
      air_speed = getAir_speed.toString();  // km/hr
      description = getDesc;
      main = getMain_des;

    }catch(e)
    {
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "Invalid Data!";
      main = "NA";
      icon = "09d";
    };
  }
}
