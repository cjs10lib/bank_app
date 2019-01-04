import 'package:bank_app/widgets/offer_details/offer_mini_carousel.dart';
import 'package:flutter/material.dart';

class OfferDetails extends StatelessWidget {
  final offerDescription =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt arcu placerat, efficitur ex ut, porta nulla. Quisque vehicula id nisi nec suscipit. Phasellus ut nunc turpis.';

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 450.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'offer-image',
          child: Image.asset(
            'assets/home/chair.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildOfferTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Lorem ipsum dolor sit',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Lorem ipsum dolor sit amet',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Material(
          elevation: 2.0,
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.transparent,
          child: Container(
            height: 40.0,
            width: 100.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                    width: 2.0, color: Theme.of(context).accentColor),
                borderRadius: BorderRadius.circular(20.0)),
            child: Text('LIKE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

  Widget _buildOfferAmount() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 40.0,
              width: 150.0,
              // color: Color.fromRGBO(0, 25, 45, .40),
              color: Color.fromRGBO(59, 70, 80, 1),
              alignment: Alignment.center,
              child: Text('Apply',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                'GHC',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5.0),
              Text(
                '20000.0',
                style: TextStyle(color: Colors.grey, fontSize: 30.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOfferDescription() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text(
        offerDescription,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(45.0),
                      topLeft: Radius.circular(45.0)),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: 50.0, right: 20.0, left: 20.0, bottom: 5.0),
                      child: _buildOfferTitle(context),
                    ),
                    _buildOfferAmount(),
                    SizedBox(height: 30.0),
                    OfferMiniCarousel(),
                    _buildOfferDescription()
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
