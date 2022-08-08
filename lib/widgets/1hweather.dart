import 'package:flutter/material.dart';

class Hourly_Weather extends StatelessWidget {
  Map hourtempmap;

  Hourly_Weather({required this.hourtempmap});



  @override
  Widget build(BuildContext context) {


    List weather = hourtempmap['weather'];
    Map weathermap = weather[0];
    DateTime date = DateTime.fromMillisecondsSinceEpoch(hourtempmap['dt'] * 1000);

    return Container(
      height: 155,
      margin: EdgeInsets.symmetric(horizontal: 11,),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(27),
      ),
      width: 75,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: 62,
              image: AssetImage('assets/images/${weathermap['icon']}.png'),
            ),
            SizedBox(height: 15,),
            Text('${date.hour}:${date.minute}', style: TextStyle(color: Colors.white),),
            Text('${hourtempmap['temp'].toInt()}°C', style: TextStyle(color: Colors.white,fontSize: 17),),
          ],
        ),
      ),
    );
  }


}
