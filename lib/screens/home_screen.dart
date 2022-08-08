import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wheater/consts.dart';
import 'package:http/http.dart' as http;
import 'package:wheater/screens/load_screen.dart';
import 'package:wheater/screens/moreresaults_screen.dart';
import 'dart:convert' as convert;
import 'package:wheater/widgets/1hweather.dart';
import 'package:wheater/widgets/dailyweather.dart';

class Home_Screen extends StatefulWidget {
  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  late Position currentPosition;

  // late String _address,_dateTime;

  LatLng initialcameraposition = LatLng(0.5937, 0.9629);
  String currentMonth = '';
  bool panelUp = false;
  late double lat = currentPosition.latitude;
  late double lon = currentPosition.longitude;
  double temp = 0.0;
  String cityName = '';
  int humidity = 0;
  double windspeed = 0;
  Map hourtempmap = {};
  Map hourtempmap1 = {};
  Map hourtempmap2 = {};
  Map hourtempmap3 = {};
  Map hourtempmap4 = {};
  Map hourtempmap5 = {};
  Map hourtempmap6 = {};
  Map hourtempmap7 = {};
  late String daytime;
  List dayTemp = [];
  Icon menu = const Icon(Icons.navigate_next);
  String description = '';
  String icon = '';
  PanelController panelController = PanelController();
  late Size size;
  // Map daytempmap = {};
  // Map daytempmap1 = {};
  // Map daytempmap2 = {};
  // Map daytempmap3 = {};
  // Map daytempmap4 = {};
  // Map daytempmap5 = {};
  // Map daytempmap6 = {};


  @override
  void initState() {
    getLoc();
    getCurrentMonth();
    // getLocation();
    getFutcherWeather();
    getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    if (hourtempmap['dt'] == null) {
      Timer(const Duration(seconds: 2), () {
        initState();
      });
      return Load_Screen(size);
    } //
    else {
      return Scaffold(
        body: SlidingUpPanel(
          onPanelOpened: () {
            setState(() {
              panelUp = true;
            });
          },
          onPanelClosed: () {
            setState(() {
              panelUp = false;
            });
          },
          controller: panelController,
          maxHeight: size.height * 0.78,
          minHeight: size.height * 0.35,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          panel: Container(
            decoration: const BoxDecoration(
              color: kPurpleColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    const Text(
                      'Today',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (panelController.panelPosition == 0.0) {
                          panelController.panelPosition = 1.0;
                          setState(() {});
                        } //
                        else {
                          panelController.panelPosition = 0.0;
                          setState(() {});
                        }
                      },
                      child: Row(
                        children: [
                          const Text(
                            'Next 7 Day',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            panelUp
                                ? Icons.keyboard_arrow_down_outlined
                                : Icons.keyboard_arrow_right_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Hourly_Weather(hourtempmap: hourtempmap),
                      Hourly_Weather(hourtempmap: hourtempmap1),
                      Hourly_Weather(hourtempmap: hourtempmap2),
                      Hourly_Weather(hourtempmap: hourtempmap3),
                      Hourly_Weather(hourtempmap: hourtempmap4),
                      Hourly_Weather(hourtempmap: hourtempmap5),
                      Hourly_Weather(hourtempmap: hourtempmap6),
                      Hourly_Weather(hourtempmap: hourtempmap7),
                    ],
                  ),
                ),
                const SizedBox(height: 45),
                Row(
                  children: [
                    const SizedBox(width: 25),
                    const Text(
                      'Next 7 Day',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                            return MoreResaults(dayTemp: dayTemp,size: size,);
                          }));
                        },
                        child: const Text(
                          'More Resaults',
                          style: TextStyle(color: Colors.white),
                        )),
                    const SizedBox(width: 25),
                  ],
                ),
                const SizedBox(height: 15),
                // Expanded(
                //   child: SingleChildScrollView(
                //     child: Column(
                //       children: [
                //         // Daily_Weather(daytempmap: daytempmap),
                //         // Daily_Weather(daytempmap: daytempmap1),
                //         // Daily_Weather(daytempmap: daytempmap2),
                //         // Daily_Weather(daytempmap: daytempmap3),
                //         // Daily_Weather(daytempmap: daytempmap4),
                //         // Daily_Weather(daytempmap: daytempmap5),
                //         // Daily_Weather(daytempmap: daytempmap6),
                //       ],
                //     ),
                //   ),
                // ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 25,
                        ),
                        Text('Temperature',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.normal,decoration: TextDecoration.none),)
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: size.height * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text('60',style: TextStyle(fontSize: 10,color: Colors.white),),
                              Text('30',style: TextStyle(fontSize: 10,color: Colors.white),),
                              Text('0',style: TextStyle(fontSize: 10,color: Colors.white),),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                          width: size.width * 0.8,
                          height: size.height * 0.25,
                          child: LineChart(
                            LineChartData(
                              borderData: FlBorderData(
                                show: false,
                              ),
                              lineTouchData: LineTouchData(enabled: true),
                              clipData: FlClipData.none(),
                              gridData: FlGridData(
                                show: false,
                                drawVerticalLine: false,
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  // belowBarData: BarAreaData(show: true),
                                    isCurved: true,
                                    color: Colors.yellow,
                                    spots: [
                                      FlSpot(0, dayTemp[1]['temp']['day']),
                                      FlSpot(1, dayTemp[2]['temp']['day']),
                                      FlSpot(2, dayTemp[3]['temp']['day']),
                                      FlSpot(3, dayTemp[4]['temp']['day']),
                                      FlSpot(4, dayTemp[5]['temp']['day']),
                                      FlSpot(5, dayTemp[6]['temp']['day']),
                                      FlSpot(6, dayTemp[7]['temp']['day']),
                                    ]),
                                // LineChartBarData(
                                //   // belowBarData: BarAreaData(show: true),
                                //     isCurved: true,
                                //     color: Colors.blue,
                                //     spots: [
                                //       FlSpot(0, widget.dayTemp[1]['temp']['min']),
                                //       FlSpot(1, widget.dayTemp[2]['temp']['min']),
                                //       FlSpot(2, widget.dayTemp[3]['temp']['min']),
                                //       FlSpot(3, widget.dayTemp[4]['temp']['min']),
                                //       FlSpot(4, widget.dayTemp[5]['temp']['min']),
                                //       FlSpot(5, widget.dayTemp[6]['temp']['min']),
                                //       FlSpot(6, widget.dayTemp[7]['temp']['min']),
                                //     ]),
                                // LineChartBarData(
                                //   // belowBarData: BarAreaData(show: true),
                                //     isCurved: true,
                                //     color: Colors.red,
                                //     spots: [
                                //       FlSpot(0, widget.dayTemp[1]['temp']['max']),
                                //       FlSpot(1, widget.dayTemp[2]['temp']['max']),
                                //       FlSpot(2, widget.dayTemp[3]['temp']['max']),
                                //       FlSpot(3, widget.dayTemp[4]['temp']['max']),
                                //       FlSpot(4, widget.dayTemp[5]['temp']['max']),
                                //       FlSpot(5, widget.dayTemp[6]['temp']['max']),
                                //       FlSpot(6, widget.dayTemp[7]['temp']['max']),
                                //     ]),
                              ],
                              titlesData: FlTitlesData(
                                show: true,
                                topTitles: AxisTitles(),
                                rightTitles: AxisTitles(sideTitles: SideTitles(reservedSize: 0, showTitles: false),),
                                // leftTitles: AxisTitles(sideTitles: SideTitles(reservedSize: 40, showTitles: true),),
                                bottomTitles: AxisTitles(),
                                leftTitles: AxisTitles(sideTitles: SideTitles(reservedSize: 0, showTitles: false),),
                              ),
                              maxX: 7,
                              maxY: 60,
                              minY: 0,
                              minX: -0,
                              baselineY: 10,
                              baselineX: 0,

                              // read about it in the LineChartData section
                            ),
                            swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                            swapAnimationCurve: Curves.linear,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:  [
                        const SizedBox(width: 0),
                        Text(Day(dayTemp[1]['dt']),style: const TextStyle(fontSize: 7,color: Colors.white),),
                        Text(Day(dayTemp[2]['dt']),style: const TextStyle(fontSize: 7,color: Colors.white),),
                        Text(Day(dayTemp[3]['dt']),style: const TextStyle(fontSize: 7,color: Colors.white),),
                        Text(Day(dayTemp[4]['dt']),style: const TextStyle(fontSize: 7,color: Colors.white),),
                        Text(Day(dayTemp[5]['dt']),style: const TextStyle(fontSize: 7,color: Colors.white),),
                        Text(Day(dayTemp[6]['dt']),style: const TextStyle(fontSize: 7,color: Colors.white),),
                        Text(Day(dayTemp[7]['dt']),style: const TextStyle(fontSize: 7,color: Colors.white),),
                        const SizedBox(width: 0),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await getLoc();
              await getCurrentWeather();
              await getFutcherWeather();
              setState(() {});
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SafeArea(
                child: Container(
                  color: Colors.white,
                  height: size.height * 0.9,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Text(
                          'Today, ${DateTime.now().day} $currentMonth',
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 27),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.black,
                              size: 40,
                            ),
                            Expanded(
                              child: Text(
                                cityName,
                                style: const TextStyle(
                                    // fontFamily: 'Anton',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              Image(
                                image: AssetImage('assets/images/$icon.png'),
                                // width: 190,
                                height: size.height * 0.23,
                              ),
                              Text(
                                description,
                                style: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontSize: 38,
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'Wind',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${windspeed.toInt()}',
                                              style:
                                                  const TextStyle(fontSize: 30),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            const Text(
                                              'm/s',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      width: 3,
                                      height: 40,
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'Temp',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${temp.toInt()}',
                                              style:
                                                  const TextStyle(fontSize: 30),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            const Text(
                                              '°C',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      width: 3,
                                      height: 40,
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'Humidity',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '$humidity',
                                              style:
                                                  const TextStyle(fontSize: 30),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            const Text(
                                              '%',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void getCurrentMonth() {
    String month = '';
    DateTime.now().month == 1
        ? month = 'January'
        : DateTime.now().month == 2
            ? month = 'February'
            : DateTime.now().month == 3
                ? month = 'March'
                : DateTime.now().month == 4
                    ? month = 'April'
                    : DateTime.now().month == 5
                        ? month = 'May'
                        : DateTime.now().month == 6
                            ? month = 'June'
                            : DateTime.now().month == 7
                                ? month = 'July'
                                : DateTime.now().month == 8
                                    ? month = 'August'
                                    : DateTime.now().month == 9
                                        ? month = 'September'
                                        : DateTime.now().month == 10
                                            ? month = 'October'
                                            : DateTime.now().month == 11
                                                ? month = 'November'
                                                : DateTime.now().month == 12
                                                    ? month = 'December'
                                                    : month = '';
    currentMonth = month;
    setState(() {});
  }

  Future<bool> getCurrentWeather() async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$kappId&units=metric&lang=en'),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          });
      Map map = convert.json.decode(response.body);
      Map tempmap = map['main'];
      Map sun = map['sys'];
      List status = map['weather'];
      Map statuss = status[0];
      Map windmap = map['wind'];
      temp = tempmap['temp'];
      cityName = map['name'];
      description = statuss['description'].toString();
      icon = statuss['icon'].toString();
      humidity = tempmap['humidity'];
      windspeed = windmap['speed'];
      if (sun['sunrise'] < map['dt'] && map['dt'] < sun['sunset']) {
        daytime = 'day';
      } //
      else {
        daytime = 'night';
      }
      setState(() {});
      return true;
    } //
    catch (e) {
      return false;
    }
  }

  Future<bool> getFutcherWeather() async {
    try {
      http.Response response = await http.get(
          Uri.parse(
              'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$kappId&units=metric'),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          });
      Map map = convert.json.decode(response.body);
      List hourTemp = map['hourly'];
      dayTemp = map['daily'];
      dayTemp = dayTemp;
      hourtempmap = hourTemp[1];
      hourtempmap1 = hourTemp[2];
      hourtempmap2 = hourTemp[3];
      hourtempmap3 = hourTemp[4];
      hourtempmap4 = hourTemp[5];
      hourtempmap5 = hourTemp[6];
      hourtempmap6 = hourTemp[7];
      hourtempmap7 = hourTemp[8];
      // daytempmap = dayTemp[1];
      // daytempmap1 = dayTemp[2];
      // daytempmap2 = dayTemp[3];
      // daytempmap3 = dayTemp[4];
      // daytempmap4 = dayTemp[5];
      // daytempmap5 = dayTemp[6];
      // daytempmap6 = dayTemp[7];
      setState(() {});
      // print(response.body);
      return true;
    } //
    catch (e) {
      return false;
    }
  }

  getLoc() async {
    bool serviceEnabled;
    LocationPermission permission;

    Geolocator.getLocationAccuracy();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    currentPosition = await Geolocator.getCurrentPosition();
    setState((){
      initialcameraposition = LatLng(
          currentPosition.latitude, currentPosition.longitude);
      lat = currentPosition.latitude;
      lon = currentPosition.longitude;
    });
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   setState(() {
    //     _currentPosition = currentLocation;
    //     _initialcameraposition = LatLng(_currentPosition.latitude ?? 0.0,
    //         _currentPosition.longitude ?? 0.0);
    //   });
    // });

  }

  String Day(int dayInt) {
    String day = '';
    if (DateTime
        .fromMillisecondsSinceEpoch(dayInt * 1000)
        .weekday == 1) {
      day = 'Sunday';
    } //
    else if (DateTime
        .fromMillisecondsSinceEpoch(dayInt * 1000)
        .weekday == 2) {
      day = 'Monday';
    } //
    else if (DateTime
        .fromMillisecondsSinceEpoch(dayInt * 1000)
        .weekday == 3) {
      day = 'Tuesday';
    }
    else if (DateTime
        .fromMillisecondsSinceEpoch(dayInt * 1000)
        .weekday == 4) {
      day = 'Wednesday';
    }
    else if (DateTime
        .fromMillisecondsSinceEpoch(dayInt * 1000)
        .weekday == 5) {
      day = 'Thursday';
    }
    else if (DateTime
        .fromMillisecondsSinceEpoch(dayInt * 1000)
        .weekday == 6) {
      day = 'Friday';
    }
    else if (DateTime
        .fromMillisecondsSinceEpoch(dayInt * 1000)
        .weekday == 7) {
      day = 'Saturday';
    }
    return day;
  }

}
