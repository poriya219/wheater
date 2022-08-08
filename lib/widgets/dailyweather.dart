import 'package:flutter/material.dart';

class Daily_Weather extends StatelessWidget {
  late String day;
  late Size size;
  Map daytempmap;


  Daily_Weather({required this.daytempmap});


  @override
  Widget build(BuildContext context) {
    Map temp = daytempmap['temp'];
    List weather = daytempmap['weather'];
    Map weathermap = weather[0];
    size = MediaQuery.of(context).size;
    if(DateTime.fromMillisecondsSinceEpoch(daytempmap['dt'] * 1000).weekday == 1){
      day = 'Sunday';
    }//
    else if(DateTime.fromMillisecondsSinceEpoch(daytempmap['dt'] * 1000).weekday == 2){
      day = 'Monday';
    }//
    else if(DateTime.fromMillisecondsSinceEpoch(daytempmap['dt'] * 1000).weekday == 3){
      day = 'Tuesday';
    }
    else if(DateTime.fromMillisecondsSinceEpoch(daytempmap['dt'] * 1000).weekday == 4){
      day = 'Wednesday';
    }
    else if(DateTime.fromMillisecondsSinceEpoch(daytempmap['dt'] * 1000).weekday == 5){
      day = 'Thursday';
    }
    else if(DateTime.fromMillisecondsSinceEpoch(daytempmap['dt'] * 1000).weekday == 6){
    day = 'Friday';
    }
    else if(DateTime.fromMillisecondsSinceEpoch(daytempmap['dt'] * 1000).weekday == 7){
      day = 'Saturday';
    }
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(27),
      ),
      width: size.width,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: 25),
            Text(day, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18),),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${temp['day'].toInt()}°C', style: const TextStyle(color: Colors.white,fontSize: 19),),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('Min: ${temp['min'].toInt()}°C', style: const TextStyle(color: Colors.blue,fontSize: 11),),
                    const SizedBox(width: 7),
                    Text('Max: ${temp['max'].toInt()}°C', style: TextStyle(color: Colors.red.shade900,fontSize: 11),),
                  ],
                ),
              ],
            ),
            SizedBox(width: 25,),
            Image(
              height: 55,
              // width: 55,
              image: AssetImage('assets/images/${weathermap['icon']}.png'),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
