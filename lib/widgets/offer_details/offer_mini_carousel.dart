import 'package:flutter/material.dart';

class OfferMiniCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      // padding: EdgeInsets.only(top: 15.0),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            height: 120.0,
            width: 160.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), color: Colors.white),
            child: FadeInImage(
              image: AssetImage('assets/home/chair.jpg'),
              placeholder: AssetImage('assets/home/chair.jpg'),
            ),
          ),
          SizedBox(width: 20.0),
          Container(
            height: 120.0,
            width: 160.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), color: Colors.white),
            child: FadeInImage(
              image: AssetImage('assets/home/chair.jpg'),
              placeholder: AssetImage('assets/home/chair.jpg'),
            ),
          ),
          SizedBox(width: 20.0),
          Container(
            height: 120.0,
            width: 160.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), color: Colors.white),
            child: FadeInImage(
              image: AssetImage('assets/home/chair.jpg'),
              placeholder: AssetImage('assets/home/chair.jpg'),
            ),
          ),
          SizedBox(width: 20.0),
          Container(
            height: 120.0,
            width: 160.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), color: Colors.white),
            child: FadeInImage(
              image: AssetImage('assets/home/chair.jpg'),
              placeholder: AssetImage('assets/home/chair.jpg'),
            ),
          ),
          SizedBox(width: 20.0),
          Container(
            height: 120.0,
            width: 160.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), color: Colors.white),
            child: FadeInImage(
              image: AssetImage('assets/home/chair.jpg'),
              placeholder: AssetImage('assets/home/chair.jpg'),
            ),
          ),
          SizedBox(width: 20.0),
        ],
      ),
    );
  }
}
