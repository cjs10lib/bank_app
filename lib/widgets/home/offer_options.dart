import 'package:flutter/material.dart';

class OfferOptions extends StatefulWidget {
  @override
  OfferOptionsState createState() => OfferOptionsState();
}

class OfferOptionsState extends State<OfferOptions> {
  bool isOffers = true;

  @override
  initState() {
    isOffers = true;
    super.initState();
  }

  Widget _buildOptionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              isOffers = true;
            });
          },
          child: Container(
            height: 70.0,
            width: 100.0,
            color: isOffers ? Theme.of(context).primaryColor : Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 50.0,
                  child: Icon(Icons.local_offer,
                      color: isOffers
                          ? Colors.white
                          : Color.fromRGBO(59, 70, 80, 1),
                      size: isOffers ? 50 : 45.0),
                ),
                Text('Offers',
                    style: TextStyle(
                        color: isOffers
                            ? Colors.white
                            : Color.fromRGBO(59, 70, 80, 1),
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isOffers = false;
            });
          },
          child: Container(
            height: 70.0,
            width: 100.0,
            color: !isOffers ? Theme.of(context).primaryColor : Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  child: Icon(Icons.event_note,
                      color: !isOffers
                          ? Colors.white
                          : Color.fromRGBO(59, 70, 80, 1),
                      size: !isOffers ? 50.0 : 45.0),
                ),
                Text('News',
                    style: TextStyle(
                        color: !isOffers
                            ? Colors.white
                            : Color.fromRGBO(59, 70, 80, 1),
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Material(
          elevation: 1.0,
          child: Container(
            height: 70.0,
            color: Colors.white,
          ),
        ),
        _buildOptionRow()
      ],
    );
  }
}
