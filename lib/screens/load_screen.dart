import 'package:flutter/material.dart';

import '../consts.dart';

class Load_Screen extends StatelessWidget {
  Size size;

  Load_Screen(this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.12,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Daily',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 40,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Weather',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 45,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Spacer(),
          const Image(
            image: AssetImage('assets/images/45592.jpg'),
          ),
          Container(
            decoration: const BoxDecoration(
              color: kPurpleColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            width: size.width,
            height: size.height * 0.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Text(
                  'Loading...',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 22,
                      color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ],
      ),

      //
      // ],
    );
  }
}
