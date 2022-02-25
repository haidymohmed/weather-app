import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/Contraller/api_helper.dart';
import 'package:weather_app/Model/city_info.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map<String? , String?>? bacImage = {"sn" : "https://images.unsplash.com/photo-1612283592698-6edf01b1edc7?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8c25vdyUyMG1vYmlsZSUyMGJhY2tncm91bmR8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60", "sl" : "https://images.unsplash.com/photo-1621717672978-5177ff1d283b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHJhaW4lMjB3ZWF0aGVyJTIwbW9iaWxlJTIwYmFja2dyb3VuZHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60", "h" : "https://images.unsplash.com/photo-1532178910-7815d6919875?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2xvdWR5JTIwc2t5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", "t" : "https://wallpaper.dog/large/20473891.jpg", "hr" : "https://images.unsplash.com/photo-1521132580291-7540211c3c39?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDN8fHJhaW4lMjAlMjBkYXl8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60", "lr" : "https://images.unsplash.com/photo-1615716277421-0a35cb41ce96?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OTJ8fHJhaW4lMjBjbG91ZCUyMCUyMGRheXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60", "s" : "https://www.novinite.com/media/images/2020-04/photo_verybig_204200.jpg", "hc" : "https://images.unsplash.com/photo-1628525805785-cc1d20e7be74?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGhlYXZ5JTIwY2xvdWQlMjAlMjBkYXl8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60", "lc" : "https://images.unsplash.com/photo-1513069020900-a162c4db0762?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjZ8fGhlYXZ5JTIwY2xvdWQlMjAlMjBkYXl8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60", "c" : "https://images.unsplash.com/photo-1622396481328-9b1b78cdd9fd?ixid=MnwxMjA3fDB8MHxzZWFyY2h8ODJ8fHN1bm55JTIwZGF5d2VhdGhlcnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"};
  late String search = "london";
  late DateTime date = DateTime.now();
  ApiHelper db = ApiHelper();
  late List<City>? city = [
    City(
        temp: 30,
        name: 'Egypt',
        icon: 'c',
        date: '2013-04-30',
        minTemp: 29,
        maxTemp: 31
    )
  ];
  getDataFromApiHelper()async{
    var len  = city!.length;
    db.getData(search).then((e){
      setState(() {
        city = e ;
      });
    });
  }
  getLocation()async{
    db.getLocation().then((e){
      setState(() {
        city = e;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              bacImage!.containsKey(city![0].icon) ?
              bacImage![city![0].icon].toString() :
              "https://images.unsplash.com/photo-1622396481328-9b1b78cdd9fd?ixid=MnwxMjA3fDB8MHxzZWFyY2h8ODJ8fHN1bm55JTIwZGF5d2VhdGhlcnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60" ,
            ),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      getLocation();
                    },
                    child: const Icon(Icons.location_city , size: 40, color: Colors.white,)
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    date.hour % 12 > 10 ?
                    "${date.hour%12} : ${date.minute}" : "0${date.hour%12} : ${date.minute}",
                    style: GoogleFonts.titilliumWeb(
                        fontSize: 80,
                        color: Colors.white
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 5
                    ),
                    child: Text(
                      date.hour > 12 ? "PM" : "AM" ,
                      style: GoogleFonts.titilliumWeb(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                  ),
                ],
              )
            ),
            SvgPicture.network(
              bacImage!.containsKey(city![0].icon) ?
              "https://www.metaweather.com/static/img/weather/${city![0].icon}.svg" :
              "https://www.metaweather.com/static/img/weather/c.svg",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Text(
                city![0].temp.toStringAsFixed(2),
              style: GoogleFonts.titilliumWeb(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            Text(
              city![0].name,
              style: GoogleFonts.titilliumWeb(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            MediaQuery.of(context).viewInsets.bottom == 0?
            SizedBox(
              width: MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.height * .32 ,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: city!.length,
                itemBuilder: (context , index){
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .5,
                      height: MediaQuery.of(context).size.height * .3 ,
                      decoration: BoxDecoration(
                        color: Colors.transparent.withOpacity(.3),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "${getMonth(city![index].date.substring(5,7))} ${city![index].date.substring(8,9) == "0"? city![index].date.substring(9,10) : city![index].date.substring(8,10) } , ${city![index].date.substring(0,4)}" ,
                              style: GoogleFonts.titilliumWeb(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Fri",
                              style: GoogleFonts.titilliumWeb(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.network(
                              bacImage!.containsKey(city![index].icon) ?
                              "https://www.metaweather.com/static/img/weather/${city![index].icon}.svg" :
                              "https://www.metaweather.com/static/img/weather/c.svg",
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "High : ${city![index].maxTemp.toStringAsFixed(2)} C",
                              style: GoogleFonts.titilliumWeb(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Low  : ${city![index].minTemp.toStringAsFixed(2)} C",
                              style: GoogleFonts.titilliumWeb(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) ;
                }
              ),
            ) : Container(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 60,
                vertical: 5
              ),
              child: TextField(
                style: GoogleFonts.titilliumWeb(
                  fontSize: 20,
                  color: Colors.white
                ),
                onSubmitted:(String value) {
                  setState(() {
                    search = value.toString();
                    date = DateTime.now();
                    getDataFromApiHelper();
                  });
                },
                decoration: InputDecoration(

                  hintStyle: GoogleFonts.titilliumWeb(
                    fontSize: 20,
                    color: Colors.white
                  ),
                  hintText: "Search City ",
                  prefixIcon: const Icon(Icons.search , color: Colors.white,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  String getMonth(month){
    switch (month) {
      case "01":
        month = "Jan";
        break;
      case "02":
        month = "Feb";
        break;
      case "03":
        month = "Mar";
        break;
      case "04":
        month = "Apr";
        break;
      case "05":
        month = "May";
        break;
      case "06":
        month = "June";
        break;
      case "07":
        month = "July";
        break;
      case "08":
        month = "Aug";
        break;
      case "09":
        month = "Sep";
        break;
      case "10":
        month = "Oct";
        break;
      case "11":
        month = "Nov";
        break;
      case "12":
        month = "Dec";
        break;
    }
    return month;
  }
}
