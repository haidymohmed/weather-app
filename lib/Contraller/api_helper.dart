import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/Model/city_info.dart';
class ApiHelper{
  var wId;
  late List<City> list = [];
  getData( String cityName) async{
    try{
      var response1 = await http.get(Uri.parse("https://www.metaweather.com/api/location/search/?query=$cityName"));
      var body1 =  jsonDecode(response1.body);
      wId = body1[0]["woeid"];
      print(wId);
      var response2 = await http.get(Uri.parse("https://www.metaweather.com/api/location/$wId/"));
      var body2 =  jsonDecode(response2.body);
      list.clear();
      body2["consolidated_weather"].forEach((element){
        var city = City(
            name: body1[0]["title"],
            temp: element["the_temp"],
            icon : element["weather_state_abbr"],
            minTemp: element["min_temp"],
            maxTemp: element["max_temp"],
            date: element["applicable_date"]
        );
        list.add(city);
      });
      return list ;
    }
    catch(e){
      print("Field");
    }
  }
  getLocation()async{
    var now = DateTime.now();
    list.clear();
    Position p = await  Geolocator.getCurrentPosition() ;
    var response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${p.latitude}&lon=${p.longitude}&appid=184ff0acb4ca0264e736d2041b97aad3"));
    var body = jsonDecode(response.body);
    var city = City(
        name: body["name"],
        temp: body["main"]["temp"]/10,
        icon : body["weather"][0]["icon"],
        minTemp: body["main"]["temp_min"],
        maxTemp: body["main"]["temp_max"],
        date: now.toString().substring(0,10)
    );
    list.add(city);
    print(list);
    return list;
  }
}