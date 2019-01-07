import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class OfferList extends StatelessWidget {
  final MainModel model;
  final String offerId, offerImage, offerTitle, offerDescription, offerImageUrl;
  final double amount;
  final bool isFavorite;

  OfferList(
      {this.model,
      @required this.offerId,
      @required this.offerImage,
      @required this.offerTitle,
      @required this.offerDescription,
      @required this.offerImageUrl,
      @required this.amount,
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
        ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return Material(
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
                  onPressed: () {
                    model.selectOffer(offerId);
                    model.toggleIsFavoriteStatus();
                  },
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildOfferDescriptionRow(BuildContext context) {
    return Container(
      height: 50.0,
      child: Column(
        children: <Widget>[
          Text(
            offerDescription.length > 60
                ? '${offerDescription.substring(0, 60)}...'
                : offerDescription.substring(0, offerDescription.length),
            style: TextStyle(fontSize: 12.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  model.selectOffer(offerId);
                  Navigator.of(context).pushNamed('/offer-details');
                },
                child: Text(
                  'show more',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOfferControlsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          height: 40.0,
          width: 120.0,
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          color: Theme.of(context).primaryColor,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('GHC',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold)),
              SizedBox(width: 5.0),
              Text('$amount',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            model.selectOffer(offerId);
            Navigator.of(context).pushNamed('/offer-details');
          },
          child: Container(
            height: 40.0,
            width: 80.0,
            // color: Color.fromRGBO(0, 25, 45, .40),
            color: Color.fromRGBO(59, 70, 80, 1),
            alignment: Alignment.center,
            child: Text('Details',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _targetWidth = _deviceWidth > 550.0 ? 500 : _deviceWidth * .95;
    double _targetPadding = _deviceWidth - _targetWidth;

    return Column(
      children: <Widget>[
        Material(
          elevation: 1.0,
          color: Colors.white,
          child: Container(
            // width: _targetWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 150.0,
                  width: 150.0,
                  child: Hero(
                      tag: offerId,
                      child: FadeInImage(
                        image: NetworkImage(offerImageUrl),
                        placeholder: AssetImage('assets/loading/loader.gif'),
                        height: 150.0,
                        width: 150.0,
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  width: 200.0,
                  padding: EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: <Widget>[
                      _buildOfferTitleRow(),
                      SizedBox(height: 10.0),
                      _buildOfferDescriptionRow(context),
                      SizedBox(height: 20.0),
                      _buildOfferControlsRow(context)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 20.0)
      ],
    );
  }
}
