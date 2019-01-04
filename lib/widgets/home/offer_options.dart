import 'package:flutter/material.dart';

class OfferOptions extends StatelessWidget {
  Widget _buildOptionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 70.0,
          child: Column(
            children: <Widget>[
              Container(
                height: 50.0,
                width: 50.0,
                child: Icon(Icons.local_offer, color: Color.fromRGBO(59, 70, 80, 1), size: 45.0),
              ),
              Text('Offers', style: TextStyle(color: Color.fromRGBO(59, 70, 80, 1), fontWeight: FontWeight.bold))
            ],
          ),
        ),
        Container(
          height: 70.0,
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                child:  Icon(Icons.event_note, color: Color.fromRGBO(59, 70, 80, 1), size: 45.0),
              ),
              Text('News', style: TextStyle(color: Color.fromRGBO(59, 70, 80, 1), fontWeight: FontWeight.bold))
            ],
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
