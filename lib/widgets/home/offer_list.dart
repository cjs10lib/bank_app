import 'package:flutter/material.dart';

class OfferList extends StatelessWidget {
  final String offerImage, offerTitle, offerDescription, value;
  final bool isFavorite;

  OfferList(
      {@required this.offerImage,
      @required this.offerTitle,
      @required this.offerDescription,
      @required this.value,
      @required this.isFavorite});

  Widget _buildOfferTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            offerTitle,
            style: TextStyle(
                color: Color.fromRGBO(59, 70, 80, 1),
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Material(
          elevation: isFavorite ? 1.0 : 0.0,
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            height: 40.0,
            width: 40.0,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              // iconSize: 30.0,
              onPressed: () {},
            ),
          ),
        )
      ],
    );
  }

  Widget _buildOfferControlsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          height: 40.0,
          width: 80.0,
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          color: Theme.of(context).primaryColor,
          alignment: Alignment.center,
          child: Text(value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 40.0,
          width: 120.0,
          // color: Color.fromRGBO(0, 25, 45, .40),
          color: Color.fromRGBO(59, 70, 80, 1),
          alignment: Alignment.center,
          child: Text('More Details',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _targetWidth = _deviceWidth > 550.0 ? 500 : _deviceWidth * .95;
    double _targetPadding = _deviceWidth - _targetWidth;

    return Material(
      elevation: 1.0,
      color: Colors.white,
      child: Container(
        // margin: EdgeInsets.all(_targetPadding),
        // height: 170,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 150.0,
              width: 150.0,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(offerImage), fit: BoxFit.cover),
              ),
            ),
            Container(
              // height: 170.0,
              width: 200.0,
              padding: EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  _buildOfferTitleRow(),
                  SizedBox(height: 10.0),
                  Container(
                    height: 50.0,
                    child: Text(
                      offerDescription,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _buildOfferControlsRow(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
