import 'package:bank_app/models/offer.dart';
import 'package:bank_app/scoped_models/main_model.dart';
import 'package:bank_app/widgets/offer_details/offer_description.dart';
import 'package:bank_app/widgets/offer_details/offer_mini_carousel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class OfferDetails extends StatelessWidget {
  final offerDescription =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt arcu placerat, efficitur ex ut, porta nulla. Quisque vehicula id nisi nec suscipit. Phasellus ut nunc turpis.';

  Widget _buildSliverAppBar(Offer offer) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 450.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: offer.id,
          child: FadeInImage(
            image: NetworkImage(offer.imageUrl),
            placeholder: AssetImage('assets/loading/loader.gif'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildOfferTitle(BuildContext context, Offer offer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${offer.title}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Location',
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

  Widget _buildOfferAmount(Offer offer) {
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
                '${offer.amount}',
                style: TextStyle(color: Colors.grey, fontSize: 30.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOfferDescription(Offer offer) {
    return OfferDescription(offer.description);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Offer selectedOffer = model.selectedOffer;

        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              _buildSliverAppBar(selectedOffer),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: 50.0, right: 20.0, left: 20.0, bottom: 5.0),
                          child: _buildOfferTitle(context, selectedOffer),
                        ),
                        _buildOfferAmount(selectedOffer),
                        SizedBox(height: 30.0),
                        // OfferMiniCarousel(),
                        _buildOfferDescription(selectedOffer)
                      ],
                    ),
                  )
                ]),
              )
            ],
          ),
        );
      },
    );
  }
}
