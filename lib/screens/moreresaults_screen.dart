import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wheater/consts.dart';
import 'package:wheater/widgets/dailyweather.dart';

class MoreResaults extends StatefulWidget {
  List dayTemp;
  Size size;

  MoreResaults({required this.dayTemp,required this.size});

  @override
  State<MoreResaults> createState() => _MoreResaultsState();
}

class _MoreResaultsState extends State<MoreResaults> {
  late String day;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPurpleColor,
      appBar: AppBar(backgroundColor: kPurpleColor,title: Text('Next 7 Day'),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Daily_Weather(daytempmap: widget.dayTemp[1]),
            Daily_Weather(daytempmap: widget.dayTemp[2]),
            Daily_Weather(daytempmap: widget.dayTemp[3]),
            Daily_Weather(daytempmap: widget.dayTemp[4]),
            Daily_Weather(daytempmap: widget.dayTemp[5]),
            Daily_Weather(daytempmap: widget.dayTemp[6]),
            Daily_Weather(daytempmap: widget.dayTemp[7]),
          ],
        ),
      ),
    );
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
